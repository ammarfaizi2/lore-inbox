Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314070AbSDVGmi>; Mon, 22 Apr 2002 02:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314073AbSDVGmh>; Mon, 22 Apr 2002 02:42:37 -0400
Received: from imladris.infradead.org ([194.205.184.45]:59920 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S314072AbSDVGmg>; Mon, 22 Apr 2002 02:42:36 -0400
Date: Mon, 22 Apr 2002 07:42:31 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: updated writeback patches for 2.5.8
Message-ID: <20020422074231.A8247@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@zip.com.au>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3CC3AD8C.630D4B74@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2002 at 11:28:28PM -0700, Andrew Morton wrote:
> Minix and sysvfs are broken - fixing those will happen shortly

I will do sysvfs - there's a large number of changes pending and it'd
rather appliy them in the right order..

> (there
> doesn't seem to be a mkfs.sysv.  Help.)

Working on it, but got sidetracked a little..
