Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932579AbWHLRnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932579AbWHLRnL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 13:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932584AbWHLRnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 13:43:10 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:32903 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932579AbWHLRnI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 13:43:08 -0400
Message-ID: <44DE1328.5080101@us.ibm.com>
Date: Sat, 12 Aug 2006 10:43:04 -0700
From: "Darrick J. Wong" <djwong@us.ibm.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       cmm@us.ibm.com, ext2-devel@lists.sourceforge.net,
       Alex Tomas <alex@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH 1/9] extents for ext4
References: <1155172827.3161.80.camel@localhost.localdomain>	<20060809233940.50162afb.akpm@osdl.org>	<m37j1hlyzv.fsf@bzzz.home.net>	<20060811135737.1abfa0f6.rdunlap@xenotime.net>	<20060811160002.b2afbec3.akpm@osdl.org> <20060811230239.c89394b0.rdunlap@xenotime.net>
In-Reply-To: <20060811230239.c89394b0.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:

> Uh, yes.  Well, I don't really care for the "ext3dev" name, but
> I tried to ignore that "feature" and fix it up anyway.
> Feel free to ignore any parts that you don't want.

Three nits to pick:

> +	  renamed ext4 fs later, once ext3dev is mature and stabled.

I think you want "stabilized", not "stabled".

(Until someone writes horsefs, that is. ;))

> +	  Other than extent maps and 48-bit block number, ext3dev also is

"...48-bit block numbers..."

> +	  By default the debugging output will be turned off.

"By default, the..."

--D
