Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264486AbTH2JNN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 05:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264471AbTH2JNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 05:13:13 -0400
Received: from zok.SGI.COM ([204.94.215.101]:55437 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S264486AbTH2JNM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 05:13:12 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: kdb@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: Announce: kdb v4.3 is available for kernel 2.4.22
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 29 Aug 2003 19:13:02 +1000
Message-ID: <12005.1062148382@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ftp://oss.sgi.com/projects/kdb/download/v4.3/

Current versions are kdb-v4.3-2.4.22-common-1.bz2,
kdb-v4.3-2.4.22-i386-1.bz2.  Other platforms will follow as they get
updated to 2.4.22.  This is just a maintenance version to sync with
kernel 2.4.22, kdb v4.4 will have more changes.  Changelog extracts
since 2.4.21.


common

2003-08-29 Keith Owens  <kaos@sgi.com>

        * kdb v4.3-2.4.22-common-1.

2003-07-27 Keith Owens  <kaos@sgi.com>

        * kdb v4.3-2.4.22-pre8-common-8.


i386

2003-08-29 Keith Owens  <kaos@sgi.com>

        * kdb v4.3-2.4.22-i386-1.

2003-08-05 Keith Owens  <kaos@sgi.com>

        * Remove duplicate setting of trap for machine_check.
        * Only reset keyboard when CONFIG_VT_CONSOLE is defined.

2003-07-27 Keith Owens  <kaos@sgi.com>

        * kdb v4.3-2.4.22-pre8-i386-5.

