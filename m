Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293531AbSBZHHf>; Tue, 26 Feb 2002 02:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293533AbSBZHHZ>; Tue, 26 Feb 2002 02:07:25 -0500
Received: from ns.caldera.de ([212.34.180.1]:25233 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S293531AbSBZHHT>;
	Tue, 26 Feb 2002 02:07:19 -0500
Date: Tue, 26 Feb 2002 08:07:12 +0100
Message-Id: <200202260707.g1Q77CJ02138@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: Dieter.Nuetzel@hamburg.de (Dieter N?tzel)
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-preX: What we really need: -AA patches finally in the tree
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <200202260135.18913.Dieter.Nuetzel@hamburg.de>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.13 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200202260135.18913.Dieter.Nuetzel@hamburg.de> you wrote:
> Without them we do _NOT_ calm the flamewar against Linux's 2.4 VM.

-aa VM is too big an uncommented - to get it into mainline someone needs
to feed it in chunks and back out obviously wrong hunks like reversing
bugfixes done in the mainline.

Other -aa parts are much saner and if no one else does it will feed big
parts to Marcelo.

> Second, it is time for the outstanding ReiserFS patches.

Maybe the reiserfs folks should submit them then?

> If we are somewhat risky we put Ingo's GREAT O(1)-scheduler in, too.

Kill source compatiblity for drivers -> no way.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
