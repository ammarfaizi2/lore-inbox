Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261326AbSJCTgA>; Thu, 3 Oct 2002 15:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261342AbSJCTgA>; Thu, 3 Oct 2002 15:36:00 -0400
Received: from thunk.org ([140.239.227.29]:48059 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S261326AbSJCTgA>;
	Thu, 3 Oct 2002 15:36:00 -0400
Date: Thu, 3 Oct 2002 15:40:50 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Hans Reiser <reiser@namesys.com>, G@thunk.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: [STUPID TESTCASE] ext3 htree vs. reiserfs on 2.5.40-mm1
Message-ID: <20021003194049.GA16329@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Hans Reiser <reiser@namesys.com>, G,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ext2-devel@lists.sourceforge.net
References: <20021001195914.GC6318@stingr.net> <20021001204330.GO3000@clusterfs.com> <20021002104859.GD6318@stingr.net> <20021002165454.GV3000@clusterfs.com> <20021003003739.GA4381@think.thunk.org> <3D9C323C.1050504@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D9C323C.1050504@namesys.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 04:04:12PM +0400, Hans Reiser wrote:
> 
> No they don't.  Average space wastage is more than 50% because sysadmins 
> have to be conservative.

Sure, but even a hundred megabytes or two out of a 100 gigabyte drive
is cheap.  (Specifically, about fifty cents' worth.)

						- Ted
