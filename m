Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbWA0GZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWA0GZh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 01:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbWA0GZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 01:25:37 -0500
Received: from bgp01360964bgs.sandia01.nm.comcast.net ([68.35.68.128]:61387
	"EHLO deneb.dwf.com") by vger.kernel.org with ESMTP
	id S1750718AbWA0GZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 01:25:37 -0500
Message-Id: <200601270625.k0R6Pa9j008293@deneb.dwf.com>
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1
To: linux-kernel@vger.kernel.org
Subject: HELP: "PCI: Fail to allocate mem resource
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 26 Jan 2006 23:25:36 -0700
From: Reg Clemens <reg@dwf.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see the following Error Message immediately after the 
'Uncompressing Linux" line at the top of the boot:

    PCI: Failed to allocate the mem resource #6:20000@48000000 for 0000:01:00.0

What does this mean/imply?

This machine is a Pentium4 on an Intel D945Gnt motherboard, with
only a nvidia 6600 video card installed.

The error message occurs for the kernel 2.6.15.1
but not for 2.6.11 (which are the only two I have tried at the moment).

Is this a known problem?
Is this a problem?
Has it been fixed (Ive scanned subject lines, but don't see anything)

-- 
                                        Reg.Clemens
                                        reg@dwf.com


