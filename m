Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbVGQLLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVGQLLs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 07:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVGQLLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 07:11:48 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:454 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S261162AbVGQLLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 07:11:46 -0400
Date: Sun, 17 Jul 2005 13:12:13 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: 7eggert@gmx.de, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] [0/5+1] menu -> menuconfig part 1
Message-ID: <Pine.LNX.4.58.0507171311400.5931@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These patches change some menus into menuconfig options.

Reworked to apply to linux-2.6.13-rc3-git3
-- 
Top 100 things you don't want the sysadmin to say:
17. dd if=/dev/null of=/vmunix
