Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264711AbTBSTsc>; Wed, 19 Feb 2003 14:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264688AbTBSTr2>; Wed, 19 Feb 2003 14:47:28 -0500
Received: from dhcp43.ists.dartmouth.edu ([129.170.249.143]:37249 "EHLO
	uml.karaya.com") by vger.kernel.org with ESMTP id <S264681AbTBSTrW>;
	Wed, 19 Feb 2003 14:47:22 -0500
Message-Id: <200302192000.h1JK0bA16426@uml.karaya.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML config changes
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 19 Feb 2003 15:00:37 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull
	http://jdike.stearns.org:5000/config-2.5

This makes a couple of changes to the UML config -
	Adds help entries where there were none before
	Removes an obsolete entry from config.release

				Jeff

 arch/um/Kconfig        |   72 +++++++++++++++++++++++++++++++++++++++++++++++++
 arch/um/config.release |    1 
 2 files changed, 72 insertions(+), 1 deletion(-)

ChangeSet@1.925.56.31, 2003-02-07 12:53:42-05:00, jdike@uml.karaya.com
  Added some help and removed an unneeded option from config.release.

