Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbUBXRA4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 12:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262296AbUBXRA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 12:00:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:5308 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262304AbUBXRAx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 12:00:53 -0500
From: john cherry <cherry@osdl.org>
Date: Tue, 24 Feb 2004 09:00:51 -0800
Message-Id: <200402241700.i1OH0pA08275@build-000.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA64 (2.6.3 - 2004-02-23.17.30) - 30 New warnings (gcc 3.3.1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/isdn/i4l/isdn_v110.c:523: warning: `ret' might be used uninitialized in this function
kernel/sys.c:255: warning: function declaration isn't a prototype
kernel/sys.c:256: warning: function declaration isn't a prototype
kernel/sys.c:257: warning: function declaration isn't a prototype
kernel/sys.c:258: warning: function declaration isn't a prototype
kernel/sys.c:259: warning: function declaration isn't a prototype
kernel/sys.c:260: warning: function declaration isn't a prototype
kernel/sys.c:261: warning: function declaration isn't a prototype
kernel/sys.c:262: warning: function declaration isn't a prototype
kernel/sys.c:265: warning: function declaration isn't a prototype
kernel/sys.c:266: warning: function declaration isn't a prototype
kernel/sys.c:267: warning: function declaration isn't a prototype
{standard input}:24118: Warning: This is the location of the conflicting usage
{standard input}:24120: Warning: Only the first path encountering the conflict is reported
{standard input}:24120: Warning: Use of 'mov' may violate WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 14
{standard input}:24968: Warning: This is the location of the conflicting usage
{standard input}:24970: Warning: Only the first path encountering the conflict is reported
{standard input}:24970: Warning: Use of 'mov' may violate WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 14
{standard input}:25721: Warning: This is the location of the conflicting usage
{standard input}:25723: Warning: Only the first path encountering the conflict is reported
{standard input}:25723: Warning: Use of 'mov' may violate WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 14
{standard input}:26616: Warning: This is the location of the conflicting usage
{standard input}:26618: Warning: Only the first path encountering the conflict is reported
{standard input}:26618: Warning: Use of 'mov' may violate WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 14
{standard input}:30687: Warning: This is the location of the conflicting usage
{standard input}:30689: Warning: Only the first path encountering the conflict is reported
{standard input}:30689: Warning: Use of 'mov' may violate WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 14
{standard input}:32389: Warning: This is the location of the conflicting usage
{standard input}:32391: Warning: Only the first path encountering the conflict is reported
{standard input}:32391: Warning: Use of 'mov' may violate WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 14
