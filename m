Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262443AbUDOLgp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 07:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262381AbUDOLgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 07:36:45 -0400
Received: from ns.suse.de ([195.135.220.2]:44166 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262443AbUDOLgo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 07:36:44 -0400
Subject: Re: [PATCH] reiserfs v3 fixes and features
From: Chris Mason <mason@suse.com>
To: Hubert Chan <hubert@uhoreg.ca>
Cc: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
In-Reply-To: <874qrmkl43.fsf@uhoreg.ca>
References: <1081274618.30828.30.camel@watt.suse.com>
	 <1081989006.27614.110.camel@watt.suse.com>  <874qrmkl43.fsf@uhoreg.ca>
Content-Type: text/plain
Message-Id: <1082029047.27614.112.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 15 Apr 2004 07:37:28 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-14 at 22:53, Hubert Chan wrote:
> On 2.6.5, it still fails:
> 
> ...
>   CC      fs/reiserfs/bitmap.o
> In file included from fs/reiserfs/bitmap.c:8:
> include/linux/reiserfs_fs.h: In function `reiserfs_transaction_running':
> include/linux/reiserfs_fs.h:1752: error: structure has no member named `journal_info'

This is from the reiser4 patch, it will get fixed when namesys updates
to the latest kernel trees.

-chris


