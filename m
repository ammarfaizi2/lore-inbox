Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261684AbUEFGBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbUEFGBi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 02:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbUEFGBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 02:01:38 -0400
Received: from ns.suse.de ([195.135.220.2]:55759 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261638AbUEFGBh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 02:01:37 -0400
Date: Thu, 6 May 2004 08:00:35 +0200
From: Andi Kleen <ak@suse.de>
To: Paul Jackson <pj@sgi.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, akpm@osdl.org,
       hch@lst.de
Subject: Re: [PATCH] NUMA API for Linux 5/ Add VMA hooks for policy
Message-ID: <20040506060035.GA8804@wotan.suse.de>
References: <20040406153322.5d6e986e.ak@suse.de> <20040406153713.52a64a26.ak@suse.de> <20040505090531.51ad5c89.pj@sgi.com> <20040505163934.GA14963@wotan.suse.de> <20040505094748.40bb7493.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040505094748.40bb7493.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2004 at 09:47:48AM -0700, Paul Jackson wrote:
> > Perhaps you missed a patch? (several of the patches depended on each other) 
> 
> No - perhaps Christoph Hellwig removed the include.

Hmm, ok. I must have missed that going in. Your patch looks correct
as an additional fix. 

Thanks,

-Andi
