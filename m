Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269197AbUHZSm6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269197AbUHZSm6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 14:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269317AbUHZSjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 14:39:13 -0400
Received: from inet-mail4.oracle.com ([148.87.2.204]:37031 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id S269316AbUHZSg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 14:36:28 -0400
Date: Thu, 26 Aug 2004 11:35:32 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Jamie Lokier <jamie@shareable.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826183532.GP1501@ca-server1.us.oracle.com>
Mail-Followup-To: Hans Reiser <reiser@namesys.com>,
	Jamie Lokier <jamie@shareable.org>,
	viro@parcelfarce.linux.theplanet.co.uk,
	Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alexander Lyamin aka FLX <flx@namesys.com>,
	ReiserFS List <reiserfs-list@namesys.com>
References: <412CEE38.1080707@namesys.com> <20040825200859.GA16345@lst.de> <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org> <20040825204240.GI21964@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408251348240.17766@ppc970.osdl.org> <20040825212518.GK21964@parcelfarce.linux.theplanet.co.uk> <20040826001152.GB23423@mail.shareable.org> <20040826003055.GO21964@parcelfarce.linux.theplanet.co.uk> <20040826010049.GA24731@mail.shareable.org> <412DA40B.5040806@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412DA40B.5040806@namesys.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 01:49:15AM -0700, Hans Reiser wrote:
> Yes, this was part of the plan, tar file-directory plugins would be cute.

	Question:  Is "cat /foo/bar/baz.tar.gz/metas" the attribute
directory or a directory in the tarball named "metas"?

Joel

-- 

"I'm so tired of being tired,
 Sure as night will follow day.
 Most things I worry about
 Never happen anyway."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
