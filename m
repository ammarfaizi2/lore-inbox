Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261511AbTCJVwX>; Mon, 10 Mar 2003 16:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261514AbTCJVwW>; Mon, 10 Mar 2003 16:52:22 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46490 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261511AbTCJVwT>;
	Mon, 10 Mar 2003 16:52:19 -0500
Date: Mon, 10 Mar 2003 22:02:54 +0000
From: Matthew Wilcox <willy@debian.org>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: Daniel Phillips <phillips@arcor.de>, John Bradford <john@grabjohn.com>,
       ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       tytso@mit.edu, adilger@clusterfs.com, chrisl@vmware.com,
       bzzz@tmi.comex.ru
Subject: Re: [Ext2-devel] Re: [RFC] Improved inode number allocation for HTree
Message-ID: <20030310220254.GA21234@parcelfarce.linux.theplanet.co.uk>
References: <200303102104.h2AL43iZ000875@81-2-122-30.bradfords.org.uk> <20030310212953.57F2310435B@mx12.arcor-online.net> <1047332834.11339.3.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047332834.11339.3.camel@serpentine.internal.keyresearch.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 10, 2003 at 01:47:14PM -0800, Bryan O'Sullivan wrote:
> Why start?  Who actually uses atime for anything at all, other than the
> tiny number of shops that care about moving untouched files to tertiary
> storage?
> 
> Surely if you want to heap someone else's plate with work, you should
> offer a reason why :-)

"You have new mail" vs "You have mail".

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
