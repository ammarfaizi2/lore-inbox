Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262629AbTCNVq1>; Fri, 14 Mar 2003 16:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262630AbTCNVq1>; Fri, 14 Mar 2003 16:46:27 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:28292 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262629AbTCNVq0>; Fri, 14 Mar 2003 16:46:26 -0500
Subject: Re: [Ext2-devel] Re: [RFC] Improved inode number allocation for
	HTree
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Matthew Wilcox <willy@debian.org>
Cc: "Bryan O'Sullivan" <bos@serpentine.com>,
       Daniel Phillips <phillips@arcor.de>, John Bradford <john@grabjohn.com>,
       ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger@clusterfs.com>,
       chrisl@vmware.com, bzzz@tmi.comex.ru, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20030310220254.GA21234@parcelfarce.linux.theplanet.co.uk>
References: <200303102104.h2AL43iZ000875@81-2-122-30.bradfords.org.uk>
	 <20030310212953.57F2310435B@mx12.arcor-online.net>
	 <1047332834.11339.3.camel@serpentine.internal.keyresearch.com>
	 <20030310220254.GA21234@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047679031.2566.616.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 14 Mar 2003 21:57:12 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2003-03-10 at 22:02, Matthew Wilcox wrote:
> On Mon, Mar 10, 2003 at 01:47:14PM -0800, Bryan O'Sullivan wrote:
> > Why start?  Who actually uses atime for anything at all, other than the
> > tiny number of shops that care about moving untouched files to tertiary
> > storage?
> > 
> > Surely if you want to heap someone else's plate with work, you should
> > offer a reason why :-)
> 
> "You have new mail" vs "You have mail".

"nodiratime" can still help there.

--Stephen

