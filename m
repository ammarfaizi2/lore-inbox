Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbTEASjH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 14:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbTEASjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 14:39:07 -0400
Received: from verein.lst.de ([212.34.181.86]:59143 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S261450AbTEASjH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 14:39:07 -0400
Date: Thu, 1 May 2003 20:48:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make <linux/blk.h> obsolete
Message-ID: <20030501204818.A16721@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Adrian Bunk <bunk@fs.tum.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <20030501200719.A16182@lst.de> <20030501183804.GC21168@fs.tum.de> <20030501204012.A16641@lst.de> <20030501184700.GD21168@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030501184700.GD21168@fs.tum.de>; from bunk@fs.tum.de on Thu, May 01, 2003 at 08:47:01PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 01, 2003 at 08:47:01PM +0200, Adrian Bunk wrote:
> > Later.  First thing is to kill the content, next the users.
> > Adding the warning now would make a normal compile very verbose..
> 
> Shall I prepare a patch removing all #include <linux/blk.h>'s?

Please do so.  That means I'll have less work to do :)

