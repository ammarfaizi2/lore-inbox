Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272039AbRIDRwz>; Tue, 4 Sep 2001 13:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272034AbRIDRwq>; Tue, 4 Sep 2001 13:52:46 -0400
Received: from h157s242a129n47.user.nortelnetworks.com ([47.129.242.157]:27320
	"EHLO zcars0m9.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S272039AbRIDRwl>; Tue, 4 Sep 2001 13:52:41 -0400
Message-ID: <3B95150B.BE5173B4@nortelnetworks.com>
Date: Tue, 04 Sep 2001 13:53:15 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Frazer <mark@somanetworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Should I use Linux to develop driver for specialized ISA card?
In-Reply-To: <E15eHup-0003ir-00@the-village.bc.nu> <01090410264000.14864@bits.linuxball> <3B950034.17909E5D@nortelnetworks.com> <20010904133227.B25240@somanetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@nortelnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Frazer wrote:

> Christopher Friesen <cfriesen@nortelnetworks.com> [01/09/04 12:29]:
> > We have a realtime process that tries to run every 50ms.  We're seeing actual
> > worst-case scheduling latencies upwards of 300-400ms.
> 
> With or without the low-latency patches?


Without.  It's PPC hardware, and the lowlatency stuff that I've found seems to
be x86-centric.



-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
