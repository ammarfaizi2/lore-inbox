Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278694AbRKDE7Z>; Sat, 3 Nov 2001 23:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278712AbRKDE7G>; Sat, 3 Nov 2001 23:59:06 -0500
Received: from raven.mail.pas.earthlink.net ([207.217.120.39]:50406 "EHLO
	raven.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S278694AbRKDE7E>; Sat, 3 Nov 2001 23:59:04 -0500
Subject: CD Writing superslow in 2.4.13-ac7
From: SubSolar <subsolar@earthlink.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16 (Preview Release)
Date: 03 Nov 2001 20:58:48 -0800
Message-Id: <1004849951.1574.5.camel@SolarCell.solarium.2y.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I guess this might be related to the IDE updates, but my 12X IDE Cendyne
burner burns at what looks like 1X in 2.4.13-ac7!  It worked fine in
2.4.13-ac5 and below.  Checked software settings and everything but it
appears to be kernel related.  I don't know if it works in 2.4.13-ac6 (I
skipped that) and have made many a coaster before figuring out the
problem.  I use SCSI emulation built into the kernel to burn with my IDE
burner, BTW (no modules).



