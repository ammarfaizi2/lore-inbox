Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264128AbTDOWB4 (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 18:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264127AbTDOWB4 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 18:01:56 -0400
Received: from snipe.mail.pas.earthlink.net ([207.217.120.62]:32211 "EHLO
	snipe.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S264128AbTDOWBz (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 18:01:55 -0400
Subject: Make RPM fails on Redhat-9
From: Steve Bangert <sbangert@mindspring.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1050444692.16505.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 15 Apr 2003 15:11:34 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Processing files: kernel-2.4.21pre7-2
Provides: kernel-2.4.21-pre7 kernel-drm
Requires(rpmlib): rpmlib(CompressedFileNames) <= 3.0.4-1
rpmlib(PayloadFilesHavePrefix) <= 4.0-1
Processing files: kernel-debuginfo-2.4.21pre7-2
error: Could not open %files file
/usr/src/redhat/BUILD/kernel-2.4.21pre7/debugfiles.list: No such file or
directory


RPM build errors:
    Could not open %files file
/usr/src/redhat/BUILD/kernel-2.4.21pre7/debugfiles.list: No such file or
directory
make: *** [rpm] Error 1
[root@localhost linux]#


Steve Bangert

