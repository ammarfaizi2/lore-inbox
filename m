Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264934AbTFWCMY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 22:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264944AbTFWCMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 22:12:24 -0400
Received: from rj.SGI.COM ([192.82.208.96]:37067 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S264934AbTFWCMX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 22:12:23 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: linux-xfs@sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: Announce: XFS split patches for 2.4.21
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 23 Jun 2003 12:25:51 +1000
Message-ID: <16782.1056335151@kao1.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ftp://oss.sgi.com/projects/xfs/download/patches/2.4.21.  

For some time the XFS group have been producing split patches for XFS,
separating the core XFS changes from additional patches such as kdb,
xattr, acl, dmapi.  The split patches are released to the world with
the hope that developers and distributors will find them useful.

Read the README in each directory very carefully, the split patch
format has changed over a few kernel releases.  Any questions that are
covered by the README will be ignored.  There is even a 2.4.22/README
for the terminally impatient :).

