Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263289AbSJOQxk>; Tue, 15 Oct 2002 12:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263321AbSJOQxk>; Tue, 15 Oct 2002 12:53:40 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:30470 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263289AbSJOQxj>; Tue, 15 Oct 2002 12:53:39 -0400
Date: Tue, 15 Oct 2002 17:59:32 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Theodore Ts'o" <tytso@mit.edu>, Christoph Hellwig <hch@infradead.org>,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] Add extended attributes to ext2/3
Message-ID: <20021015175932.A31409@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Theodore Ts'o <tytso@mit.edu>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <E181IS8-0001DQ-00@snap.thunk.org> <20021015125816.A22877@infradead.org> <20021015131507.GC31235@think.thunk.org> <20021015163121.B27906@infradead.org> <20021015164116.GD31235@think.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021015164116.GD31235@think.thunk.org>; from tytso@mit.edu on Tue, Oct 15, 2002 at 12:41:16PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 12:41:16PM -0400, Theodore Ts'o wrote:
> On Tue, Oct 15, 2002 at 04:31:21PM +0100, Christoph Hellwig wrote:
> > 
> > Patch 2: mbcache (all against 2.5.42-mm3):
> > 
> > o remove LINUX_VERSION_CODE mess
> 
> Note that this was fixed in the version I sent out; I don't think
> Andrew grabbed my latest patches.  Anyway, I'll merge in the various
> suggested changes, and send Andrew an updated patch.

Well, it'ß still in the patch series I that started this thread.
I haven't seen newer patches yet.

