Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292261AbSBBJho>; Sat, 2 Feb 2002 04:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292260AbSBBJhf>; Sat, 2 Feb 2002 04:37:35 -0500
Received: from tapu.f00f.org ([63.108.153.39]:50877 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S292259AbSBBJhR>;
	Sat, 2 Feb 2002 04:37:17 -0500
Date: Sat, 2 Feb 2002 01:35:56 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Steve Lord <lord@sgi.com>
Cc: Andrew Morton <akpm@zip.com.au>, Ricardo Galli <gallir@uib.es>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Chris Mason <mason@suse.com>
Subject: Re: O_DIRECT fails in some kernel and FS
Message-ID: <20020202093554.GA7207@tapu.f00f.org>
In-Reply-To: <E16WkQj-0005By-00@antoli.uib.es> <3C5AFE2D.95A3C02E@zip.com.au> <1012597538.26363.443.camel@jen.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1012597538.26363.443.camel@jen.americas.sgi.com>
User-Agent: Mutt/1.3.27i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 03:05:38PM -0600, Steve Lord wrote:

    > ext2 is the only filesystem which has O_DIRECT support.

    And XFS ;-)

I sent reiserfs O_DIRECT support patches to someone a while ago.  I
can look to ressurect these (assuming I can find them!)

Chris Mason is always going to be a better source for these anyhow, he
certainly understands any complex nuances there may be.  Chris, do you
have any cycles to comment on this please?




  --cw
