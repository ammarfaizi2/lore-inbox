Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267076AbTAPNg2>; Thu, 16 Jan 2003 08:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267080AbTAPNg2>; Thu, 16 Jan 2003 08:36:28 -0500
Received: from smtpcl3.fiducia.de ([195.200.32.20]:46008 "EHLO
	smtpcl3.fiducia.de") by vger.kernel.org with ESMTP
	id <S267076AbTAPNg2>; Thu, 16 Jan 2003 08:36:28 -0500
Sensitivity: 
Subject: [i2c-piix4.o: IBM Laptop detected; this module may corrupt your serial
 eeprom! Refusing to load module!] on xSeries 232 -Server
To: "linux-kernel" <linux-kernel@vger.kernel.org>
From: "Andreas Hartmann" <andreas.hartmann@fiducia.de>
Date: Thu, 16 Jan 2003 14:45:12 +0100
Message-ID: <OFDA940B31.E3BDE6F7-ON41256CB0.0049452E@fag.fiducia.de>
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I'm using kernel 2.4.19 (SuSE 8.1; k_deflt-2.4.19-174 - actual patch release) on
an IBM xSeries 232 Server. When I'm trying to load the module i2c-piix4, the
module claims, it would be running on an IBM Laptop. This is definitely wrong.
The old SuSE kernel (k_deflt-2.4.19-49) didn't show this problem.

Could you please fix this problem or am I wrong?


Thank you very much,
kind regards,
Andreas Hartmann


