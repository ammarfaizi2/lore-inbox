Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265228AbUE0UyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265228AbUE0UyX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 16:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265232AbUE0UyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 16:54:22 -0400
Received: from [213.146.154.40] ([213.146.154.40]:18094 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265228AbUE0UyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 16:54:20 -0400
Date: Thu, 27 May 2004 21:54:19 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@infradead.org>, David Johnson <dj@david-web.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Can't make XFS work with 2.6.6
Message-ID: <20040527205419.GA20499@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Johnson <dj@david-web.co.uk>, linux-kernel@vger.kernel.org
References: <200405271736.08288.dj@david-web.co.uk> <20040527205124.GA20430@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040527205124.GA20430@infradead.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2004 at 09:51:24PM +0100, Christoph Hellwig wrote:
> On Thu, May 27, 2004 at 05:36:08PM +0100, David Johnson wrote:
> > Hello,
> > 
> > I'm having a problem getting my system to boot with 2.6.6 and a XFS root 
> > filesystem. On boot it can't mount the root fs:
> > 
> > XFS: Bad magic number
> > XFS: SB validate failed
> > Kernel Panic: VFS: Unable to mount root fs on unknown-block(0,0)
> 
> This means your block driver isn't compiled in.  What device is your filesystem
> on, are you using devfs or similar crap?

Ok, the later mails answer the questions.  Sorry for the noise.

