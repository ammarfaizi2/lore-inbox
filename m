Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318369AbSGRVKO>; Thu, 18 Jul 2002 17:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318372AbSGRVKN>; Thu, 18 Jul 2002 17:10:13 -0400
Received: from verein.lst.de ([212.34.181.86]:55309 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S318369AbSGRVKN>;
	Thu, 18 Jul 2002 17:10:13 -0400
Date: Thu, 18 Jul 2002 23:13:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vmap_pages()
Message-ID: <20020718231313.A6939@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	linux-kernel@vger.kernel.org
References: <20020718230003.A6500@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020718230003.A6500@lst.de>; from hch@lst.de on Thu, Jul 18, 2002 at 11:00:03PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 11:00:03PM +0200, Christoph Hellwig wrote:
> There's more and more pressure getting XFS into mainline now that most
> distributors ship it and SGI's Red Hat-based installers are in wide use,
> and although most of the core kernel changes in the XFS tree have been
> removed by redesigning/rewriting XFS code.

[please Cc Linus & linux-mm on replies, I've fucked it up..]

