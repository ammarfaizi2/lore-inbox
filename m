Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbUIHM3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUIHM3R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 08:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbUIHM3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 08:29:17 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:5129 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261711AbUIHM3K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 08:29:10 -0400
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove dead exports from fs/fat/
References: <20040907144355.GB8717@lst.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 08 Sep 2004 21:28:20 +0900
In-Reply-To: <20040907144355.GB8717@lst.de> (Christoph Hellwig's message of
 "Tue, 7 Sep 2004 16:43:55 +0200")
Message-ID: <87n001rlln.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> These were used by the defunct umsdos code only.

Thanks. I'll submit to -mm tree.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
