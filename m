Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283460AbRK3Bvq>; Thu, 29 Nov 2001 20:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283463AbRK3Bvh>; Thu, 29 Nov 2001 20:51:37 -0500
Received: from dsl-213-023-039-029.arcor-ip.net ([213.23.39.29]:64782 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S283460AbRK3Bv1>;
	Thu, 29 Nov 2001 20:51:27 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: paulus@samba.org, torvalds@transmeta.com (Linus Torvalds)
Subject: Re: 2.5.1-pre2 does not compile
Date: Fri, 30 Nov 2001 02:53:50 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200111272044.fARKiTv13653@db0bm.ampr.org> <9u0ua1$1g2$1@penguin.transmeta.com> <15364.3457.368582.994067@gargle.gargle.HOWL>
In-Reply-To: <15364.3457.368582.994067@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E169csB-0000iD-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 27, 2001 11:02 pm, Paul Mackerras wrote:
> Is there a description of the new block layer and its interface to
> block device drivers somewhere?  That would be helpful, since Ben
> Herrenschmidt and I are going to have to convert several
> powermac-specific drivers.

   http://lse.sourceforge.net/io/bionotes.txt 
   (Writeup by Suparna on Jens' work and design issues, +5, insightful)

--
Daniel
