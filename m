Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265983AbRF1O46>; Thu, 28 Jun 2001 10:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265986AbRF1O4j>; Thu, 28 Jun 2001 10:56:39 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:52485
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S265983AbRF1O43>; Thu, 28 Jun 2001 10:56:29 -0400
Date: Thu, 28 Jun 2001 10:55:47 -0400
From: Chris Mason <mason@suse.com>
To: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: [PATCH] reiserfs_write_inode calls during memory pressure
Message-ID: <34890000.993740147@tiny>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi guys,

This patch makes reiserfs_write_inode skip the com


