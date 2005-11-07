Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965002AbVKGRvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965002AbVKGRvo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 12:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965015AbVKGRvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 12:51:44 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:63753 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S965002AbVKGRvn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 12:51:43 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/6] fat: Support a truncate() for expanding size
References: <87hdaotlci.fsf@devron.myhome.or.jp>
	<87d5lctl5y.fsf@devron.myhome.or.jp>
	<878xw0tl3r.fsf_-_@devron.myhome.or.jp>
	<874q6otl0q.fsf_-_@devron.myhome.or.jp>
	<87zmogs6cs.fsf_-_@devron.myhome.or.jp>
	<87vez4s6b7.fsf_-_@devron.myhome.or.jp>
	<87r79ss658.fsf_-_@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 08 Nov 2005 02:51:35 +0900
In-Reply-To: <87r79ss658.fsf_-_@devron.myhome.or.jp> (OGAWA Hirofumi's message of "Tue, 08 Nov 2005 02:46:11 +0900")
Message-ID: <87mzkgs5w8.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for broken index.

[PATCH 1/7] fat: move fat_clusters_flush() to write_super()
[PATCH 2/7] fat: use sb_find_get_block() instead of sb_getblk()
[PATCH 3/7] fat: add the read/writepages()
[PATCH 4/7] fat: s/EXPORT_SYMBOL/EXPORT_SYMBOL_GPL/
[PATCH 5/7] fat: support ->direct_IO()
[PATCH 6/7] export/change sync_page_range/_nolock()
[PATCH 7/7] fat: Support a truncate() for expanding size

The above is right index. If I need to resend, please tell me.

Note for reviewers, [6/7] patch is not a part of fatfs.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
