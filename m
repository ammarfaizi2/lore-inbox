Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVGUBZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVGUBZX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 21:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVGUBZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 21:25:15 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:57542 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S261574AbVGUBZK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 21:25:10 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: kdb@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: kdb v4.4 supports OHCI keyboard in 2.6
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 21 Jul 2005 11:24:59 +1000
Message-ID: <19923.1121909099@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 2.6.13-rc3 version of KDB (Linux Kernel Debugger) supports a USB
keyboard (CONFIG_KDB_USB).  At the moment it only supports the OHCI
interface, this is what SGI hardware uses.  If anybody has hardware
that uses the UHCI interface for the keyboard and can create a kdb
patch, that patch will be gratefully accepted.

ftp://oss.sgi.com/projects/kdb/download/v4.4/
ftp://ftp.ocs.com.au/pub/mirrors/oss.sgi.com/projects/kdb/download/v4.4/

