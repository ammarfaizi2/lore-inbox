Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266739AbRGFPk3>; Fri, 6 Jul 2001 11:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266740AbRGFPkT>; Fri, 6 Jul 2001 11:40:19 -0400
Received: from h131s117a129n47.user.nortelnetworks.com ([47.129.117.131]:16003
	"HELO pcard0ks.ca.nortel.com") by vger.kernel.org with SMTP
	id <S266739AbRGFPkI>; Fri, 6 Jul 2001 11:40:08 -0400
Message-ID: <3B45DBDC.BCC66169@nortelnetworks.com>
Date: Fri, 06 Jul 2001 11:40:12 -0400
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: are ioctl calls supposed to take this long?
In-Reply-To: <Pine.LNX.3.95.1010706112457.1472A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> On Fri, 6 Jul 2001, Chris Friesen wrote:

> > Are you sure about this?  In the tulip.c driver the following appears to be the
> > salient code:

<snip>

>                ..... This falls through to
>         SIOCDEVPRIVATE+1


Doh!  Okay, I need caffeine, or sugar, or something...
Sorry about that.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
