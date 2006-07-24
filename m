Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbWGXOl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbWGXOl1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 10:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWGXOl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 10:41:27 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:3717 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932195AbWGXOl0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 10:41:26 -0400
Subject: Re: [PATCH] fs: Memory allocation cleanups
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: takis@issaris.org
Cc: linux-kernel@vger.kernel.org, rathamahata@php4.ru, sfrench@samba.org,
       jffs-dev@axis.com, neilb@cse.unsw.edu.au, trond.myklebust@fys.uio.no,
       reiserfs-dev@namesys.com, raven@themaw.net
In-Reply-To: <20060721115055.GA12329@issaris.org>
References: <20060721115055.GA12329@issaris.org>
Content-Type: text/plain
Date: Mon, 24 Jul 2006 09:41:19 -0500
Message-Id: <1153752079.10822.6.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-21 at 13:50 +0200, takis@issaris.org wrote:
> From: Panagiotis Issaris <takis@issaris.org>
> 
> - Remove useless casts from k(m|z)alloc and vmallocs
> - One conversion of kmalloc+memset to kzalloc
> 
> Signed-off-by: Panagiotis Issaris <takis@issaris.org>

Acked-by: Dave Kleikamp <shaggy@austin.ibm.com>

The jfs part looks good.

Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

