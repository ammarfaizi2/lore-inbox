Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130463AbRACOJv>; Wed, 3 Jan 2001 09:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130897AbRACOJl>; Wed, 3 Jan 2001 09:09:41 -0500
Received: from mailgate1.zdv.Uni-Mainz.DE ([134.93.8.56]:37301 "EHLO
	mailgate1.zdv.Uni-Mainz.DE") by vger.kernel.org with ESMTP
	id <S130463AbRACOJY>; Wed, 3 Jan 2001 09:09:24 -0500
Date: Wed, 3 Jan 2001 14:38:48 +0100
From: Dominik Kubla <dominik.kubla@uni-mainz.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: Further ACPI woes with 2.4.0-prerelease
Message-ID: <20010103143848.A29029@uni-mainz.de>
Mail-Followup-To: Dominik Kubla <dominik.kubla@uni-mainz.de>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.11i
X-No-Archive: yes
Restrict: no-external-archive
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just tried 2.4.0-prerelease on my workstation at work (hmm, totally new
meaning of "workstation"...).  It's a no-name dual Pentium-II (300) with
a Tyan Tiger 2 board.  Also i have "ACPI-aware OS" enabled in BIOS, the
kernel states:

  ACPI: System description tables not found

Any idea how to proceed? Obviously there should be some ACPI tables
somewhere.  Since this is my personal workstation (apart from being our
MP2 server as well) i can test at will.

Dominik Kubla
-- 
http://petition.eurolinux.org/index_html - No Software Patents In Europe!
http://petition.lugs.ch/ (in Switzerland)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
