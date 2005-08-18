Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbVHRNyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbVHRNyL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 09:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbVHRNyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 09:54:11 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:45531 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S932230AbVHRNyK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 09:54:10 -0400
X-ORBL: [63.205.185.3]
Date: Thu, 18 Aug 2005 06:53:56 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: xfs-masters@oss.sgi.com, nathans@sgi.com, linux-xfs@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pull XFS support out of Kconfig submenu
Message-ID: <20050818135356.GA16845@taniwha.stupidest.org>
References: <200508172245.49043.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508172245.49043.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2005 at 10:45:48PM +0200, Jesper Juhl wrote:

> It seems slightly odd to me that XFS support should be in a separate
> submenu, when all the other filesystems are not using submenus but
> are directly selectable from the Filesystems menu.

XFS also has an out-of-tree version.  Making it a submenu is probably
to make maintenance easier (ie. replace files, not merge).

