Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965024AbVHJHDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbVHJHDU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 03:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965028AbVHJHDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 03:03:20 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:9663 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965024AbVHJHDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 03:03:19 -0400
Date: Wed, 10 Aug 2005 08:03:09 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: David Teigland <teigland@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: [PATCH 00/14] GFS
Message-ID: <20050810070309.GA2415@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	David Teigland <teigland@redhat.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, linux-cluster@redhat.com
References: <20050802071828.GA11217@redhat.com> <20050809152045.GT29811@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050809152045.GT29811@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2005 at 04:20:45PM +0100, Al Viro wrote:
> On Tue, Aug 02, 2005 at 03:18:28PM +0800, David Teigland wrote:
> > Hi, GFS (Global File System) is a cluster file system that we'd like to
> > see added to the kernel.  The 14 patches total about 900K so I won't send
> > them to the list unless that's requested.  Comments and suggestions are
> > welcome.  Thanks
> > 
> > http://redhat.com/~teigland/gfs2/20050801/gfs2-full.patch
> > http://redhat.com/~teigland/gfs2/20050801/broken-out/
> 
> Kindly lose the "Context Dependent Pathname" crap.

Same for ocfs2.

