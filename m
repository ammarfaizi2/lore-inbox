Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311320AbSCVNVu>; Fri, 22 Mar 2002 08:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312336AbSCVNVk>; Fri, 22 Mar 2002 08:21:40 -0500
Received: from [213.53.96.130] ([213.53.96.130]:43015 "EHLO
	mail.technology.asb.nl") by vger.kernel.org with ESMTP
	id <S311320AbSCVNVa>; Fri, 22 Mar 2002 08:21:30 -0500
Message-ID: <C159F0A1CD3ED411A8A600508B556292091B25@mx-int.technology.asb.nl>
From: Sander Storms <s.storms@technology.asb.nl>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: C-Media 8783 driver
Date: Fri, 22 Mar 2002 14:15:19 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Does anyone know a descent driver for the C-Media 8783?
The current driver included in kernel 2.4.18 does work correctly, except for
the FM-chip and the Midi-output.
There is although support for /dev/dmfm added, but the wrong device-number
is allocated (minor nr. 15), and
the functionality of it is not guaranteed. Furthermore the device is not
usable for standard music-player.
I know it is possible to address the FM-chip with /dev/sequencer (see
ALSA-drivers), but the current kernel-driver
does not support this.

--------------------------------------------
ASB Technology BV
De Ronde 15A
5683 CZ  Best
The Netherlands
tel.  ++31 499 365077
fax. ++31 499 365099

S.Storms@technology.asb.nl
--------------------------------------------

