Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269524AbRHHS1g>; Wed, 8 Aug 2001 14:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269531AbRHHS11>; Wed, 8 Aug 2001 14:27:27 -0400
Received: from mta1n.bluewin.ch ([195.186.1.210]:53187 "EHLO mta1n.bluewin.ch")
	by vger.kernel.org with ESMTP id <S269524AbRHHS1U>;
	Wed, 8 Aug 2001 14:27:20 -0400
Message-ID: <3B6E44EE000EFE33@mta1n.bluewin.ch> (added by postmaster@bluewin.ch)
From: "Per Jessen" <per.jessen@enidan.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rob" <rwideman@austin.rr.com>
Date: Wed, 08 Aug 2001 20:34:42 +0200
Reply-To: "Per Jessen" <per.jessen@enidan.com>
X-Mailer: PMMail 98 Professional (2.01.1600) For Windows 95 (4.0.1212)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: configuring the kernel
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

0On Wed, 8 Aug 2001 12:11:44 -0500, Rob wrote:

>Qustions:
>1-does "make menuconfig" require X to be installed? I dont have X, i just
>have RH 7.1 with kernel dev and kernel sources installed (atleast those were
>the ONLY things i had selected during install).

No, no requirement for X. 

>2-if i untared/unpacked the kernel to the folder /root/newkern (here is
>where i did the "gzip -cd linux 2.4.7...... |tar xvf -" command) is it ok to
>delete the newkern folder and unpack nd then do the "make menuconfig"?

Yep, sounds ok to me. I tend to keep my kernel sources in /usr/src/linux-2.4.7,
with a symlink /usr/src/linux->linux-2.4.7. Dunno if that's the convention,
but it works for me.

Rob, you would probably be better off asking this on the linux newbie list - 
the kernel list is very busy.
Hope this helps - feel free to mail me directly.


regards,
Per Jessen





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


