Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132531AbRDHKm4>; Sun, 8 Apr 2001 06:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132534AbRDHKmr>; Sun, 8 Apr 2001 06:42:47 -0400
Received: from smtp3.xs4all.nl ([194.109.127.132]:13577 "EHLO smtp3.xs4all.nl")
	by vger.kernel.org with ESMTP id <S132531AbRDHKmh>;
	Sun, 8 Apr 2001 06:42:37 -0400
Date: Sun, 8 Apr 2001 10:42:11 +0000
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.4.2 ac2x & 2.4.3. loss of VC displays
Message-ID: <20010408104211.A2095@grobbebol.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-OS: Linux grobbebol 2.4.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all

regently I see weird things with X.

XFree86 Version 4.0.2 / X Window System
(protocol Version 11, revision 0, vendor release 6400)
Release Date: 18 December 2000

(II) NV: driver for NVIDIA chipsets: RIVA128, RIVATNT, RIVATNT2,
        RIVATNT2 (Ultra), RIVATNT2 (Vanta), RIVATNT2 M64,
        RIVATNT2 (Integrated), GeForce 256, GeForce DDR, Quadro,
        GeForce2 GTS, GeForce2 GTS (rev 1), GeForce2 ultra, Quadro 2 Pro,
        GeForce2 MX, GeForce2 MX DDR, Quadro 2 MXR, GeForce 2 Go
(--) Chipset RIVATNT found

this is a SuSE 7.0 std X thing. no specific NVIDIA obfuscated source
binary or something.

what happens is that after some time, I switch back & forth from and to
X. sometimes, most within a day of work, switching from X to a VC, the
VC's blank. it reacts to commands but display is blank.

I don't have special modules launched and no patches to the kernel
except the lm_sensors / i2c stuff. removed it for test and still
happens.

someone an idea ?


-- 
Grobbebol's Home                   |  Don't give in to spammers.   -o)
http://www.xs4all.nl/~bengel       | Use your real e-mail address   /\
Linux 2.2.16 SMP 2x466MHz / 256 MB |        on Usenet.             _\_v  
