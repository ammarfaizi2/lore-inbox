Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264147AbUH0M11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbUH0M11 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 08:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263980AbUH0M11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 08:27:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53182 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264260AbUH0M0W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 08:26:22 -0400
Date: Fri, 27 Aug 2004 13:26:21 +0100
From: Matthew Wilcox <willy@debian.org>
To: Markus =?iso-8859-1?Q?T=F6rnqvist?= <mjt@nysv.org>
Cc: Hans Reiser <reiser@namesys.com>, Jamie Lokier <jamie@shareable.org>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040827122621.GT16196@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org> <20040825204240.GI21964@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408251348240.17766@ppc970.osdl.org> <20040825212518.GK21964@parcelfarce.linux.theplanet.co.uk> <20040826001152.GB23423@mail.shareable.org> <20040826003055.GO21964@parcelfarce.linux.theplanet.co.uk> <20040826010049.GA24731@mail.shareable.org> <412DA40B.5040806@namesys.com> <20040826183532.GP1501@ca-server1.us.oracle.com> <20040827091954.GZ1284@nysv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040827091954.GZ1284@nysv.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 12:19:54PM +0300, Markus   Törnqvist wrote:
> That's why I tend to rename metas/ into ..metas/ to avoid
> name clashes, even if I've never had a directory named metas/
> apart from what Reiser4 ships.

http://packages.debian.org/cgi-bin/search_contents.pl?word=metas&searchmode=searchfilesanddirs&case=insensitive&version=unstable&arch=i386

OK, those are capital METAS rather than junior metas, but it does show
this is not a unique word to reiser4.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
