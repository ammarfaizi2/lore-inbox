Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262017AbULVSas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbULVSas (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 13:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbULVSas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 13:30:48 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:56512 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S262018AbULVS3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 13:29:34 -0500
Date: Wed, 22 Dec 2004 13:29:33 -0500
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       debian-kernel@lists.debian.org
Subject: Re: Problem with XFS and/or VM deadlock in 2.6.8
Message-ID: <20041222182933.GB26253@csclub.uwaterloo.ca>
References: <20041222141600.GA26253@csclub.uwaterloo.ca> <20041222182103.GA14586@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041222182103.GA14586@infradead.org>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2004 at 06:21:03PM +0000, Christoph Hellwig wrote:
> All this should be fixed in 2.6.10-rc3.  The XFS code in Debian's 2.6.8
> is very much out of data and has various problems, but 2.6.8 is already
> really old and the various required core code changes make it hard to
> backport the XFS fixes.

Well I will keep an eye out for when 2.6.10 is released then and upgrade
to that.  As long as it is a known and fixed problem I can live with
that.  It hasn't been and issue for me more than once a month or so when
I go on major cleanup hunts.

I was starting to think I had to convert to ext3 which would be quite a
hassle.

Len Sorensen
