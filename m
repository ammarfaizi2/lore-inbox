Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161163AbWAHGWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161163AbWAHGWU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 01:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161164AbWAHGWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 01:22:20 -0500
Received: from xenotime.net ([66.160.160.81]:20365 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1161163AbWAHGWT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 01:22:19 -0500
Date: Sat, 7 Jan 2006 22:22:17 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: jeff shia <tshxiayu@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: where is the source of FAT32 filesystem
Message-Id: <20060107222217.43f67396.rdunlap@xenotime.net>
In-Reply-To: <7cd5d4b40601072208m6984ba52qf11f1986900987e6@mail.gmail.com>
References: <7cd5d4b40601072208m6984ba52qf11f1986900987e6@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Jan 2006 14:08:36 +0800 jeff shia wrote:

> Hello,
> 
> where is the source of FAT32 filesystem in the kernel source tree?
> or where can I get the source?

If you have the kernel tree, look in

fs/fat + fs/msdos + fs/vfat

They have some interdependencies.

---
~Randy
