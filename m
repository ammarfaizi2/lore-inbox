Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266181AbUH1LPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266181AbUH1LPx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 07:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266208AbUH1LPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 07:15:53 -0400
Received: from nysv.org ([213.157.66.145]:26028 "EHLO nysv.org")
	by vger.kernel.org with ESMTP id S266181AbUH1LPv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 07:15:51 -0400
Date: Sat, 28 Aug 2004 14:14:12 +0300
To: flx@msu.ru, Christoph Hellwig <hch@lst.de>,
       Christophe Saout <christophe@saout.de>, Andrew Morton <akpm@osdl.org>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com, torvalds@osdl.org,
       reiserfs-list@namesys.com
Subject: Re: reiser4 plugins (was: silent semantic changes with reiser4)
Message-ID: <20040828111412.GG1284@nysv.org>
References: <20040825152805.45a1ce64.akpm@osdl.org> <412D9FE6.9050307@namesys.com> <20040826014542.4bfe7cc3.akpm@osdl.org> <1093522729.9004.40.camel@leto.cs.pocnet.net> <20040826124929.GA542@lst.de> <1093525234.9004.55.camel@leto.cs.pocnet.net> <20040826130718.GB820@lst.de> <1093526273.11694.8.camel@leto.cs.pocnet.net> <20040826132439.GA1188@lst.de> <20040828105929.GB6746@alias>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040828105929.GB6746@alias>
User-Agent: Mutt/1.5.6i
From: mjt@nysv.org (Markus  =?ISO-8859-1?Q?=20T=F6rnqvist?=)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 02:59:29PM +0400, Alexander Lyamin wrote:
>P.S. I imagine, how much flamed it would be if reiser4 made any intensive
>changes in linux VFS code...

Surely it would be flamefest galore, but thanks to Reiser4 there may be
some VFS changes to that direction, maybe completely from Reiser4.
Should keep some people at bay if the chances weren't so much replacing
VFS than extending it.

-- 
mjt

