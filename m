Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314395AbSG2KRr>; Mon, 29 Jul 2002 06:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314403AbSG2KRr>; Mon, 29 Jul 2002 06:17:47 -0400
Received: from [195.63.194.11] ([195.63.194.11]:12046 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314395AbSG2KRq>; Mon, 29 Jul 2002 06:17:46 -0400
Message-ID: <3D4515E8.2010107@evision.ag>
Date: Mon, 29 Jul 2002 12:16:08 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Andries Brouwer <aebr@win.tue.nl>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.28
References: <1027553482.11881.5.camel@sonja.de.interearth.com> <Pine.LNX.4.44.0207241803410.4293-100000@home.transmeta.com> <20020727235726.GB26742@win.tue.nl> <20020728024739.GA28873@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Sun, Jul 28, 2002 at 01:57:26AM +0200, Andries Brouwer wrote:
> 
>>My third candidate is USB. Systems without USB are clearly more stable.
> 
> 
> Hm, then that would imply that all of my systems are unstable :)
> 
> Seriously, I don't know of any outstanding 2.5 USB issues that cause
> oopses right now, or effect stability.  Any problems that people are
> having, they sure are not telling me, or the other USB developers
> about...
> 
> thanks,

Please please learn how to use __FUNCTION__ properly. I see the same
crap over and over again in security. OK? Please tell me a way how
to dual boot a system with the new host controller names between 2.4 and
  2.5. Putting redundant alias lines in /etc/modules.conf didn't work.


