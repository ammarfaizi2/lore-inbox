Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264756AbSJOQf2>; Tue, 15 Oct 2002 12:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264757AbSJOQf2>; Tue, 15 Oct 2002 12:35:28 -0400
Received: from thunk.org ([140.239.227.29]:13518 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S264756AbSJOQf1>;
	Tue, 15 Oct 2002 12:35:27 -0400
Date: Tue, 15 Oct 2002 12:41:16 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Christoph Hellwig <hch@infradead.org>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] Add extended attributes to ext2/3
Message-ID: <20021015164116.GD31235@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Christoph Hellwig <hch@infradead.org>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <E181IS8-0001DQ-00@snap.thunk.org> <20021015125816.A22877@infradead.org> <20021015131507.GC31235@think.thunk.org> <20021015163121.B27906@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021015163121.B27906@infradead.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 04:31:21PM +0100, Christoph Hellwig wrote:
> 
> Patch 2: mbcache (all against 2.5.42-mm3):
> 
> o remove LINUX_VERSION_CODE mess

Note that this was fixed in the version I sent out; I don't think
Andrew grabbed my latest patches.  Anyway, I'll merge in the various
suggested changes, and send Andrew an updated patch.

						- Ted
