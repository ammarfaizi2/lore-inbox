Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266488AbRHAKcR>; Wed, 1 Aug 2001 06:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266464AbRHAKcH>; Wed, 1 Aug 2001 06:32:07 -0400
Received: from mta2n.bluewin.ch ([195.186.1.211]:45287 "EHLO mta2n.bluewin.ch")
	by vger.kernel.org with ESMTP id <S266400AbRHAKb6>;
	Wed, 1 Aug 2001 06:31:58 -0400
Message-ID: <3B5D8A0A002D181A@mta2n.bluewin.ch> (added by postmaster@bluewin.ch)
From: "Per Jessen" <per.jessen@enidan.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-laptop@vger.kernel.org" <linux-laptop@vger.kernel.org>
Date: Wed, 01 Aug 2001 12:40:01 +0200
Reply-To: "Per Jessen" <per.jessen@enidan.com>
X-Mailer: PMMail 98 Professional (2.01.1600) For Windows 95 (4.0.1111)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: PCMCIA control I82365 stops working with 2.4.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 May 2001 20:23:03 +0100, Per Jessen wrote:

>I recently installed 2.4.4 on my toshiba tecra8100 laptop, and
>noticed that the load of the i82365 module no longer works.
>The PCIC is not detected.
>I switched back to 2.4.3, and everything works fine.

I have since moved on to 2.4.5, 2.4.6 and 2.4.7 - the i82365 is
still not being detected. Should I be talking to Toshiba about this ?
Not having the i82365 module loaded means not being able to use my
PCMCIA network card - pretty bad situation. 

Also, I have WinNT installed too - when I switch between WinNT boot
Linux, unless I press RESET, my PCMCIA card is not properly recognised.
This I can live with, but it's still a bug.

Am I addressing the right mailing-list ? I'll copy this to lkml,
just in case. 


regards,
Per 




regards,
Per Jessen, Principal Engineer, ENIDAN Technologies Ltd
http://www.enidan.com - home of the J1 serial console.

----------------------------------------------------------
Please note:  This message is intended for the use of the individual to 
whom it is addressed and may contain information which is privileged, 
confidential and exempt from disclosure under applicable law. If the reader 
of this message is not the intended, or is not the employee or agent 
responsible for delivering the message to the intended recipient, you are 
hereby notified that any dissemination, distribution, or copying of this
communication is strictly prohibited.  If you have received this 
communication in error, please notify the sender immediately by return
email.  Thank you.


