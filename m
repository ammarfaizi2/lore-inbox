Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272464AbRIQTI5>; Mon, 17 Sep 2001 15:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272511AbRIQTIs>; Mon, 17 Sep 2001 15:08:48 -0400
Received: from 63-151-64-156.hsacorp.net ([63.151.64.156]:6151 "EHLO
	boojiboy.eorbit.net") by vger.kernel.org with ESMTP
	id <S272464AbRIQTIn>; Mon, 17 Sep 2001 15:08:43 -0400
From: chris@boojiboy.eorbit.net
Message-Id: <200109172004.NAA14399@boojiboy.eorbit.net>
Subject: Re: 2.4.9-ac9 APM w/Compaq 16xx laptop...
To: J.A.K.Mouw@ITS.TUDelft.NL, alan@lxorguk.ukuu.org.uk
Date: Mon, 17 Sep 2001 13:04:14 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alan and Erik,

The Linux Kernel mailing list does not seem to be
bearing any fruit with this APM/ACPI issue regarding
clean power-off/reboot.  Are there any other groups
that you are aware of that might have interest in
investigating this bug?

--Chris

**************************************************
I still have linux-2.4.9-ac9, with the dmi_scan.c patch,
and the APM configured as you suggested.  My computer
bios is set to ACPI=off (even with this 'on' the behavior
is the same).

shutdown -h    works correctly
shutdown -r    hangs at "Restarting System".

