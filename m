Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266329AbTGJLFK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 07:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269201AbTGJLFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 07:05:10 -0400
Received: from air-2.osdl.org ([65.172.181.6]:48066 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266329AbTGJLFG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 07:05:06 -0400
Date: Thu, 10 Jul 2003 04:20:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] minor optimization for EXT3
Message-Id: <20030710042016.1b12113b.akpm@osdl.org>
In-Reply-To: <87smpeigio.fsf@gw.home.net>
References: <87smpeigio.fsf@gw.home.net>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas <bzzz@tmi.comex.ru> wrote:
>
> Andreas Dilger proposed do not read inode's block during inode updating
>  if we have enough data to fill that block. here is the patch.

ok, thanks.  Could you please redo it for the current kernel?

