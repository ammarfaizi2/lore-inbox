Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135879AbRDTL4l>; Fri, 20 Apr 2001 07:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135880AbRDTL4a>; Fri, 20 Apr 2001 07:56:30 -0400
Received: from mail2.bonn-fries.net ([62.140.6.78]:8972 "HELO
	mail2.bonn-fries.net") by vger.kernel.org with SMTP
	id <S135879AbRDTL4U>; Fri, 20 Apr 2001 07:56:20 -0400
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andreas Dilger <adilger@turbolinux.com>,
        Ext2 development mailing list 
	<ext2-devel@lists.sourceforge.net>,
        Linux kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [Ext2-devel] [PATCH] update ext2 documentation
Date: Fri, 20 Apr 2001 14:07:34 +0200
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <200104201016.f3KAGwct030395@webber.adilger.int>
In-Reply-To: <200104201016.f3KAGwct030395@webber.adilger.int>
MIME-Version: 1.0
Message-Id: <01042014132609.01958@subspace.radio>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Apr 2001, Andreas Dilger wrote:
> The included patch updates Documentation/filesystems/ext2 to reflect
> current information about ext2.  It also adds some more information
> that people have told me is hard to find in other places (such as a
> description of the superblock compatibility flags, file and filesystem
> size limits).

To quote Oliver Twist: "Please, Sir, I want some more".  How about a
explanation of the significance of GOOD_OLD_REV, etc.  In particular, I'm
curious why CURRENT_REV is defined as GOOD_OLD_REV and not DYNAMIC_REV.

--
Daniel
