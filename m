Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbVBGQMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVBGQMK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 11:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbVBGQMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 11:12:10 -0500
Received: from penguin.cohaesio.net ([212.97.129.34]:44209 "EHLO
	mail.cohaesio.net") by vger.kernel.org with ESMTP id S261173AbVBGQMH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 11:12:07 -0500
From: Anders Saaby <as@cohaesio.com>
Organization: Cohaesio A/S
To: "Jeffrey E. Hundstad" <jeffrey.hundstad@mnsu.edu>
Subject: Re: linux-2.6.11-rc3: XFS internal error xfs_da_do_buf(1) at line 2176 of file fs/xfs/xfs_da_btree.c.
Date: Mon, 7 Feb 2005 17:13:02 +0100
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
References: <42078B74.2080306@mnsu.edu>
In-Reply-To: <42078B74.2080306@mnsu.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502071713.03158.as@cohaesio.com>
X-OriginalArrivalTime: 07 Feb 2005 16:12:05.0991 (UTC) FILETIME=[C46B2F70:01C50D2F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is this system running SMP og UP?

On Monday 07 February 2005 16:38, Jeffrey E. Hundstad wrote:
> I'm sorry for this truncated report... but it's all I've got.  If you
> need .config or system configuration, etc. let me know and I'll send'em
> ASAP.  I don't believe this is hardware related; ide-smart shows all fine.
>
>  From dmesg:
>
> xfs_da_do_buf: bno 8388608
> dir: inode 117526252
> Filesystem "hda4": XFS internal error xfs_da_do_buf(1) at line 2176 of
> file fs/x

-- 
Med venlig hilsen - Best regards - Meilleures salutations

Anders Saaby
Systems Engineer
------------------------------------------------
Cohaesio A/S - Maglebjergvej 5D - DK-2800 Lyngby
Phone: +45 45 880 888 - Fax: +45 45 880 777
Mail: as@cohaesio.com - http://www.cohaesio.com
------------------------------------------------
