Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269316AbUH0JY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269316AbUH0JY3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 05:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269260AbUH0JY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 05:24:26 -0400
Received: from nysv.org ([213.157.66.145]:21658 "EHLO nysv.org")
	by vger.kernel.org with ESMTP id S269402AbUH0JXF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 05:23:05 -0400
Date: Fri, 27 Aug 2004 12:21:31 +0300
To: Lee Revell <rlrevell@joe-job.com>
Cc: Christophe Saout <christophe@saout.de>, Will Dyson <will_dyson@pobox.com>,
       Jamie Lokier <jamie@shareable.org>, Chris Wedgwood <cw@f00f.org>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040827092131.GA1284@nysv.org>
References: <20040825212518.GK21964@parcelfarce.linux.theplanet.co.uk> <20040826001152.GB23423@mail.shareable.org> <20040826003055.GO21964@parcelfarce.linux.theplanet.co.uk> <20040826010049.GA24731@mail.shareable.org> <20040826100530.GA20805@taniwha.stupidest.org> <20040826110258.GC30449@mail.shareable.org> <412E06B2.7060106@pobox.com> <1093552705.5678.96.camel@krustophenia.net> <1093553429.13881.48.camel@leto.cs.pocnet.net> <1093553846.5678.102.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093553846.5678.102.camel@krustophenia.net>
User-Agent: Mutt/1.5.6i
From: mjt@nysv.org (Markus  =?ISO-8859-1?Q?=20T=F6rnqvist?=)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 04:57:26PM -0400, Lee Revell wrote:
>On Thu, 2004-08-26 at 16:50, Christophe Saout wrote:
>> are read-only and system-wide and the user-overridden changes. I don't
>> know if all of these things would really make sense inside the kernel.
>True.  FWIW, I never use most of those features.  It's just too damn
>slow.  Windows seems to implement all of the useful features of
>GnomeVFS, and they are 10x faster.

Are they in the kernel in Windows?

-- 
mjt

