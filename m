Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286712AbSBCK1s>; Sun, 3 Feb 2002 05:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286758AbSBCK1i>; Sun, 3 Feb 2002 05:27:38 -0500
Received: from postfix2-1.free.fr ([213.228.0.9]:4736 "EHLO postfix2-1.free.fr")
	by vger.kernel.org with ESMTP id <S286712AbSBCK10>;
	Sun, 3 Feb 2002 05:27:26 -0500
From: Willy Tarreau <wtarreau@free.fr>
Message-Id: <200202031027.g13ARMN03118@ns.home.local>
Subject: Re: 760MPX IO/APIC Errors...
To: jon-anderson@rogers.com
Date: Sun, 3 Feb 2002 11:27:22 +0100 (CET)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

same motherboard here, but with 2 XP1800+.
It couldn't boot until I either disabled IO/APIC or disable MPS1.4 support
in the bios setup. Finally, I disabled MPS1.4 and let IO/APIC enabled and
it works really well in SMP. (In fact, I couldn't really imagine how fast
this could be !)

Regards,
Willy

