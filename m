Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281047AbRKYUgZ>; Sun, 25 Nov 2001 15:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281048AbRKYUgP>; Sun, 25 Nov 2001 15:36:15 -0500
Received: from cpe-66-1-134-68.ca.sprintbbd.net ([66.1.134.68]:64717 "HELO
	core.sitedirection.com") by vger.kernel.org with SMTP
	id <S281047AbRKYUgJ>; Sun, 25 Nov 2001 15:36:09 -0500
Message-ID: <006701c175f1$d9b10630$0f00a8c0@minniemouse>
From: "Jon" <marsaro@interearth.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <87adxbxkk1.fsf@toboggan.in.ibm.com>
Subject: Re: i815 Card ...Machine Freezes
Date: Sun, 25 Nov 2001 12:43:34 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Power Management in the BIOS on or compiled into your Kernel?

Regards,

Jon
----- Original Message -----
From: "Sid Carter" <sidcarter@symonds.net>
To: <linux-kernel@vger.kernel.org>
Sent: Sunday, November 25, 2001 1:32 AM
Subject: i815 Card ...Machine Freezes


> Hi,
>
> My Machine with a Intel i815 card hangs if it is not used for
> sometime. The monitor goes blank and after sometime if I don't use the
> machine , the system hangs. I can't even use the power switch to
> poweroff the machine. I have to pull out the power cable from the back
> of the machine. Kernel am using is 2.4.14 with SGi's XFS Patch.
>
> And when I am using X, If I switch from X to console and vice-versa
> more than once, my machine hangs. Is this a known problem ? The logs
> show no errors at all. Let me know if more info is required.
>
> The relevant output of lspci below:
>
> 00:00.0 Host bridge: Intel Corp. 82815 815 Chipset Host Bridge and Memory
Controller Hub (rev 02)
> 00:02.0 VGA compatible controller: Intel Corp. 82815 CGC [Chipset Graphics
Controller] (rev 02)
>
> TIA
> Regards
>         Carter
> --
> The only difference between your girlfriend and a barracuda is the
nailpolish.
>
> Sid Carter                                                   Debian
GNU/Linux.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

