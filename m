Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262550AbRFTQDB>; Wed, 20 Jun 2001 12:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262564AbRFTQCv>; Wed, 20 Jun 2001 12:02:51 -0400
Received: from THANK.THUNK.ORG ([216.175.175.163]:27332 "EHLO thunk.org")
	by vger.kernel.org with ESMTP id <S262550AbRFTQCe>;
	Wed, 20 Jun 2001 12:02:34 -0400
Date: Wed, 20 Jun 2001 12:02:13 -0400
From: Theodore Tso <tytso@valinux.com>
To: Tony Gale <gale@syntax.dera.gov.uk>
Cc: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net, Alexander Viro <viro@math.psu.edu>,
        Andreas Dilger <adilger@turbolinux.com>
Subject: Re: [Ext2-devel] Re: [UPDATE] Directory index for ext2
Message-ID: <20010620120213.B22993@think.thunk.org>
Mail-Followup-To: Theodore Tso <tytso@valinux.com>,
	Tony Gale <gale@syntax.dera.gov.uk>,
	Daniel Phillips <phillips@bonn-fries.net>,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
	Alexander Viro <viro@math.psu.edu>,
	Andreas Dilger <adilger@turbolinux.com>
In-Reply-To: <0105311813431J.06233@starship> <993049198.3089.2.camel@syntax.dera.gov.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <993049198.3089.2.camel@syntax.dera.gov.uk>; from gale@syntax.dera.gov.uk on Wed, Jun 20, 2001 at 03:59:58PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2001 at 03:59:58PM +0100, Tony Gale wrote:
> 
> The main problem I have with this is that e2fsck doesn't know how to
> deal with it - at least I haven't found a version that will. This makes
> it rather difficult to use, especially for your root fs.

Getting e2fsck to deal with directory indexing is on my todo list at
this point.  

Daniel, do you have any preliminary patches to start with, or do I
need to start from scratch?  

						- Ted
