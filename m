Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290593AbSAYHr6>; Fri, 25 Jan 2002 02:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290594AbSAYHrs>; Fri, 25 Jan 2002 02:47:48 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:18703 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id <S290593AbSAYHrn>; Fri, 25 Jan 2002 02:47:43 -0500
From: Norbert Preining <preining@logic.at>
Date: Fri, 25 Jan 2002 08:34:27 +0100
To: Daniel Nofftz <nofftz@castor.uni-trier.de>
Cc: linux-kernel@vger.kernel.org
Subject: amd athlon cooling and kernel freeze
Message-ID: <20020125083427.A25245@alpha.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel! Hi List!

I tried the Athlon patch and when I enabled acpi instead of apm
I get kernel freezes, nothing works, not even Sysrq, nothing in the
log file.

It happened one while playing a avi with mplayer and once while playing
mp3 with xmms.

Live1024 Soundcard.

I used the implementation of acpi in the kernel 2.4.18.7 and not the
one from intel pages, because it didn't compile (missing asm/acpi.h,
other problems).

Best wishes

Norbert

-----------------------------------------------------------------------
Norbert Preining <preining@logic.at> 
University of Technology Vienna, Austria            gpg DSA: 0x09C5B094
-----------------------------------------------------------------------
SCONSER (n.)

A person who looks around then when talking to you, to see if there's
anyone more interesting about.

			--- Douglas Adams, The Meaning of Liff 
