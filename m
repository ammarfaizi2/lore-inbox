Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264756AbSL1Pex>; Sat, 28 Dec 2002 10:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265098AbSL1Pex>; Sat, 28 Dec 2002 10:34:53 -0500
Received: from mnh-1-01.mv.com ([207.22.10.33]:44036 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S264756AbSL1Peu>;
	Sat, 28 Dec 2002 10:34:50 -0500
Message-Id: <200212281547.KAA02093@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML documentation updates 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 28 Dec 2002 10:47:05 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull either
	http://uml.bkbits.net/doc-2.5
or	http://jdike.stearns.org:5000/doc-2.5

This updates the UML documentation:
	adds help text back to the UML config
	deletes the old config.in files
	puts the UML HOWTO in Documentation/uml

				Jeff

 Documentation/uml/UserModeLinux-HOWTO.txt | 4686 ++++++++++++++++++++++++++++++
 arch/um/Kconfig                           |   85 
 arch/um/Kconfig_block                     |   34 
 arch/um/Kconfig_char                      |   76 
 arch/um/config_block.in                   |   16 
 arch/um/config_char.in                    |   37 
 arch/um/config_net.in                     |   46 
 arch/um/config_scsi.in                    |   30 
 8 files changed, 4878 insertions(+), 132 deletions(-)

ChangeSet@1.797.69.2, 2002-11-18 14:22:01-05:00, jdike@uml.karaya.com
  Added the UML HOWTO in Documentation/uml.

ChangeSet@1.797.53.1, 2002-11-17 15:36:15-05:00, jdike@uml.karaya.com
  Merged the help text from the 2.4 Configure.help.


