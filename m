Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284529AbRLPIuz>; Sun, 16 Dec 2001 03:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284535AbRLPIup>; Sun, 16 Dec 2001 03:50:45 -0500
Received: from p15.dynadsl.ifb.co.uk ([194.105.168.15]:21123 "HELO smeg")
	by vger.kernel.org with SMTP id <S284529AbRLPIug>;
	Sun, 16 Dec 2001 03:50:36 -0500
From: "Lee Packham" <linux@mswinxp.net>
To: <linux-kernel@vger.kernel.org>
Subject: FW: Intel 810 Problems/Solutions
Date: Sun, 16 Dec 2001 08:49:35 -0000
Message-ID: <000601c1860e$96726cb0$0102a8c0@lee>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry if this has appeared more than once... I mucked up!

> -----Original Message-----
> From: Lee Packham [mailto:linux@mswinxp.net]
> Sent: 16 December 2001 06:12
> To: 'linux-kernel@vger.kernel.org''
> Subject: Intel 810 Problems/Solutions
> 
> Hi,
> 
> I have a Sony Vaio PCG-FX103 laptop that I play around with Linux
stuff
> on. Sound has been an issue. With the latest kernel (plus various
patches
> that have appeared in linux-kernel) cause a major squeal on a DivX
file I
> recorded off the TV on another Linux box. The only place I get the
squeal
> is on the laptop. Under Windows its OK, on my other Linux box its ok,
just
> on this Intel 810 sound card laptop thing it squeals.
> 
> So, I installed ALSA and it went away but I got the chipmunk problem.
> However, the only documentation that said about setting the ac97 codec
> frequency to 41194 really was just tooooo slow (like groaning
stretched
> out sound). The default 48000 was chipmunk. I used another PC to
calibrate
> and came up with 47500. That little bit slows it down to the right
speed.
> 
> Now I know this isn't the ALSA group, just thought this info would
help
> people out who are working on the Intel 810 driver in the kernel. BTW:
if
> you want the file its about a 200MB avi of an Eastenders episode but
you
> are welcome to have it to test out fixes.
> 
> Lee Packham

