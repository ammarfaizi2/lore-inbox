Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265095AbSJWQ5X>; Wed, 23 Oct 2002 12:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265083AbSJWQ5K>; Wed, 23 Oct 2002 12:57:10 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:14606 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S265094AbSJWQzY>; Wed, 23 Oct 2002 12:55:24 -0400
Date: Wed, 23 Oct 2002 18:01:34 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Matt D. Robinson" <yakker@aparity.com>
Cc: linux-kernel@vger.kernel.org, lkcd-devel@lists.sourceforge.net
Subject: Re: [PATCH] LKCD for 2.5.44 (7/8): dump configuration
Message-ID: <20021023180134.C16547@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Matt D. Robinson" <yakker@aparity.com>,
	linux-kernel@vger.kernel.org, lkcd-devel@lists.sourceforge.net
References: <Pine.LNX.4.44.0210230241050.27315-100000@nakedeye.aparity.com> <Pine.LNX.4.44.0210230244440.27315-100000@nakedeye.aparity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210230244440.27315-100000@nakedeye.aparity.com>; from yakker@aparity.com on Wed, Oct 23, 2002 at 02:44:55AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 02:44:55AM -0700, Matt D. Robinson wrote:
> +else
> +   define_tristate CONFIG_CRASH_DUMP_BLOCKDEV n
> +   define_tristate CONFIG_CRASH_DUMP_COMPRESS_RLE n
> +   define_tristate CONFIG_CRASH_DUMP_COMPRESS_GZIP n

What's the reason for this?

