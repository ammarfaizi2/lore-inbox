Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbVACT4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbVACT4k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 14:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbVACT4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 14:56:40 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:14048 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261648AbVACT4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 14:56:34 -0500
Date: Mon, 3 Jan 2005 14:56:32 -0500
To: colin <colin@realtek.com.tw>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to use udftools to make up a DVD with DVD-Video format
Message-ID: <20050103195632.GA30311@csclub.uwaterloo.ca>
References: <005d01c4f15a$ef4bf620$8b1a13ac@realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005d01c4f15a$ef4bf620$8b1a13ac@realtek.com.tw>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 02:10:33PM +0800, colin wrote:
> We try to make up a DVD-Video disc on Linux.
> DVD-Video disc contains a UDF/ISO9660 filesystem, and every file in it
> should occupy the right sectors.
> I know that mkisofs can do this, but we want to record video on-the-fly.
> mkisofs doesn't support this functionality.
> Therefore we would like to use UDF filesystem and udftools to do this.
> Can I use them to make up a DVD with a UDF/ISO9660 filesystem and every file
> in it occupies specified sectors?

I suspect the cdwrite mailing list (hosted on lists.debian.org) would be
a better place to ask for help on that.  They tend to be very
responsive to questions.

http://lists.debian.org/cdwrite/

Len Sorensen
