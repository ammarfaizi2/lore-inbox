Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263996AbTKZIva (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 03:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263998AbTKZIva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 03:51:30 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:12051 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263996AbTKZIv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 03:51:29 -0500
Date: Wed, 26 Nov 2003 08:51:23 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test10-mm1
Message-ID: <20031126085123.A1952@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20031125211518.6f656d73.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031125211518.6f656d73.akpm@osdl.org>; from akpm@osdl.org on Tue, Nov 25, 2003 at 09:15:18PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 25, 2003 at 09:15:18PM -0800, Andrew Morton wrote:
> +invalidate_mmap_range-non-gpl-export.patch
> 
>  Export invalidate_mmap_range() to all modules

Why?

