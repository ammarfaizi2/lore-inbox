Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281420AbRKZC0r>; Sun, 25 Nov 2001 21:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281428AbRKZC0i>; Sun, 25 Nov 2001 21:26:38 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:9955 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S281427AbRKZC0a>;
	Sun, 25 Nov 2001 21:26:30 -0500
Subject: Re: i815 Card ...Machine Freezes
In-Reply-To: <87adxbxkk1.fsf@toboggan.in.ibm.com>
	<006701c175f1$d9b10630$0f00a8c0@minniemouse>
From: Sid Carter <sidcarter@symonds.net>
URL: http://www.symonds.net/~sidcarter/
Operating-System: Turing OS XCVII
Disclaimer: Not speaking for anyone in any way, shape, or form.
Copyright: Copyright 2001 Sid Carter - All Rights Reserved
To: linux-kernel@vger.kernel.org
Reply-To: sidcarter@symonds.net
Organization: Sid Carter Inc.
Date: 26 Nov 2001 07:56:00 +0530
In-Reply-To: <006701c175f1$d9b10630$0f00a8c0@minniemouse>
Message-ID: <87oflquv2f.fsf@toboggan.in.ibm.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sun, 25 Nov 2001 12:43:34 -0800, "Jon" <marsaro@interearth.com> said:

    Jon> Power Management in the BIOS on or compiled into your Kernel?
    Jon> Regards,

    >> sometime. The monitor goes blank and after sometime if I don't use the
    >> machine , the system hangs. I can't even use the power switch to
    >> poweroff the machine. I have to pull out the power cable from the back
    >> of the machine. Kernel am using is 2.4.14 with SGi's XFS Patch.
    >> 
    >> And when I am using X, If I switch from X to console and vice-versa
    >> more than once, my machine hangs. Is this a known problem ? The logs
    >> 00:00.0 Host bridge: Intel Corp. 82815 815 Chipset Host Bridge and Memory
    Jon> Controller Hub (rev 02)
    >> 00:02.0 VGA compatible controller: Intel Corp. 82815 CGC [Chipset Graphics
    Jon> Controller] (rev 02)

Hi,
Power Management is enabled in the BIOS *and* compiled into my kernel
also.APM is compiled in. I tried to use APIC, but APIC won't poweroff
my machine when I halt it, hence use APM. Is this freeze due to
APM/Power Management ?
TIA
Regards
        Carter
-- 
The only difference between your girlfriend and a barracuda is the nailpolish.

Sid Carter                                                   Debian GNU/Linux.
