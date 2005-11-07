Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964960AbVKGWoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964960AbVKGWoU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 17:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965584AbVKGWoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 17:44:19 -0500
Received: from adsl-69-227-249-30.dsl.pltn13.pacbell.net ([69.227.249.30]:20486
	"EHLO TwinPeakSoft.com") by vger.kernel.org with ESMTP
	id S964960AbVKGWoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 17:44:16 -0500
Message-Id: <200511072256.jA7MufJ07565@TwinPeakSoft.com>
Date: Mon, 7 Nov 2005 14:43:55 -0800 (PST)
From: johnpw <johnpw@TwinPeakSoft.com>
Reply-To: johnpw <johnpw@TwinPeakSoft.com>
Subject: Access other file system's symbols 
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: /FWDtXHvyNLaRDnK7LgWDw==
X-Mailer: dtmail 1.3.0 @(#)CDE Version 1.5.3_06 SunOS 5.9 sun4u sparc 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greetings,

I need to access some ext3 and nfs file system
symbols from a new file system module we are 
developing. For example, the nfs_file_inode_operations
and ext3_dir_inode_operations. What functions 
or mechanism in the kernel are available for 
doing that? Any suggestions and advice is 
appreciated.

John W.

