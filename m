Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262190AbTBJRIY>; Mon, 10 Feb 2003 12:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262418AbTBJRIY>; Mon, 10 Feb 2003 12:08:24 -0500
Received: from smtp1.wlink.com.np ([202.79.32.76]:976 "HELO smtp1.wlink.com.np")
	by vger.kernel.org with SMTP id <S262190AbTBJRIW>;
	Mon, 10 Feb 2003 12:08:22 -0500
Message-ID: <000c01c2d128$51cc0f60$0100a8c3@wesserver>
From: "npguy" <wl2625@wlink.com.np>
To: "John W. M. Stevens" <john@betelgeuse.us>
Cc: <linux-kernel@vger.kernel.org>
References: <20030209042031.GA1222@morningstar.nowhere.lie>
Subject: Re: Bug Report (New Info about PS/2 Mouse)
Date: Mon, 10 Feb 2003 23:02:39 +0545
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

same probs with me, overall same config...! wheneveri try to load mouse
module the system freeze...noway but to reboot ...any fix around?

- npguy
ysgnet.com
----- Original Message -----
From: "John W. M. Stevens" <john@betelgeuse.us>
To: <linux-kernel@vger.kernel.org>
Sent: Sunday, February 09, 2003 10:05 AM
Subject: Bug Report (New Info about PS/2 Mouse)


> The bug I reported earlier does occur when a PS/2 mouse is plugged
> in to the box.  The hang no longer occurs every time, but it still
> occurs.
>
> [1.] One line summary of the problem:
>
>    Defect is kernel hang on Dual Processor, Athlon MP system.
>
> [2.] Full description of the problem/report:
>
>    The system regularly experiences short (from 1 to 5 seconds)
>    hangs where both processors appear to be "hung".  Most often,
>    the system will recover, but in three different cases the
>    system has hung "permanently" (for values of "permanently"
>    ranging from 10 minutes, to at most four hours before I gave
>    up and hit reset).
>
> [3.] Keywords (i.e., modules, networking, kernel):
>
>    Hard freeze.
>
> [4.] Kernel version (from /proc/version):
>
>    Linux version 2.4.20 (root@morningstar)
>    (gcc version 2.95.4 20011002 (Debian prerelease))
>    #20 SMP Thu Feb 6 20:35:14 MST 2003
>
> [5.] Output of Oops.
>
>    Sorry, but since the system hung, there was no Oops.
>
> [6.] A small shell script or example program which triggers the
>       problem (if possible)
>
>    Two steps: 1) enable support for AMD Viper chipset and using
>    DMA by default.  2) Using IDE-SCSI, attemp to burn a CD.
>






