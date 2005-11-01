Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbVKAPGD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbVKAPGD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 10:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbVKAPGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 10:06:03 -0500
Received: from c71.sam-solutions.net ([217.21.35.67]:56381 "EHLO
	c71.sam-solutions.net") by vger.kernel.org with ESMTP
	id S1750728AbVKAPGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 10:06:02 -0500
Subject: Re: [Linux-NTFS-Dev] [2.6-GIT] NTFS: Release 2.1.25.
From: Yura Pakhuchiy <y.pakhuchi@sam-solutions.net>
Reply-To: Yura Pakhuchiy <pakhuchiy@gmail.com>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
In-Reply-To: <1130856987.7361.1.camel@imp.csi.cam.ac.uk>
References: <Pine.LNX.4.64.0510311408160.27357@hermes-1.csi.cam.ac.uk>
	 <1130790267.2276.8.camel@localhost>
	 <Pine.LNX.4.64.0510312040010.10190@hermes-1.csi.cam.ac.uk>
	 <1130793939.2104.19.camel@localhost>
	 <Pine.LNX.4.64.0510312136500.10190@hermes-1.csi.cam.ac.uk>
	 <1130856488.12766.14.camel@pc299.sam-solutions.net>
	 <1130856987.7361.1.camel@imp.csi.cam.ac.uk>
Content-Type: text/plain
Organization: SaM-Solutions
Date: Tue, 01 Nov 2005 17:01:46 +0200
Message-Id: <1130857307.12767.15.camel@pc299.sam-solutions.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 (2.4.1-alt2) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Nov 2005 15:06:00.0789 (UTC) FILETIME=[C544A050:01C5DEF5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-01 at 14:56 +0000, Anton Altaparmakov wrote:
> On Tue, 2005-11-01 at 16:48 +0200, Yura Pakhuchiy wrote:
> > On Mon, 2005-10-31 at 21:54 +0000, Anton Altaparmakov wrote:
> > > > About me, I did not tested this code before, at least because you had
> > > > not posted patches to mailing list when you send it to -mm. Sorry, but I
> > > > do not have git repository.
> > > 
> > > That is a lame excuse:
> > > 
> > > 1) -mm contains the patch (obviously) as a single file in the split out 
> > > directory in Andrew's file space on kernel.org (where you would go to 
> > > download the -mm kernel anyway).
> > > 
> > > 2) If you had told me so I could have either posted the patches or put 
> > > them somewhere for you...  It takes me about 10 seconds to generate them:
> > > 
> > > cd /usr/src/ntfs-2.6-devel
> > > git format-patch -n <linus' head>
> > > 
> > > And I get all the patches output to disk...
> > 
> > That was explanation, not excuse. If you want people to test your code,
> > you should prepare it in form comfortable for them to test. Sorry, but I
> > do not have time for searching where I can download code you need to
> > test. I think that many others potential testers do not use git too, and
> > link to patch or inlined patches much more comfortable for them.
> 
> I guess I just assume that anyone using -mm kernels know where the
> patches are (in case you did not know -mm is not in git, it is simple
> pathes, one for the whole -mm and then there are broken out patches, so
> there is an ntfs patch).

Yes, I had not knew that. Thanks.

-- 
Best regards,
        Yura

