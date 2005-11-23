Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932593AbVKWWuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593AbVKWWuN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932594AbVKWWuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:50:13 -0500
Received: from xenotime.net ([66.160.160.81]:27358 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932593AbVKWWuK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:50:10 -0500
Date: Wed, 23 Nov 2005 14:50:05 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Adrian Bunk <bunk@stusta.de>
cc: zippel@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fs/hfsplus/: move the hfsplus_inode_check() prototype
 to hfsplus_fs.h
In-Reply-To: <20051123223508.GG3963@stusta.de>
Message-ID: <Pine.LNX.4.58.0511231449120.20189@shark.he.net>
References: <20051123223508.GG3963@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2005, Adrian Bunk wrote:

> Function prototypes belong into header files.

I'd like to see someone fix kernel/power/disk.c also....

-- 
~Randy
