Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbVHYPas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbVHYPas (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 11:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbVHYPas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 11:30:48 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:13505 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932149AbVHYPar (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 11:30:47 -0400
Date: Thu, 25 Aug 2005 17:30:33 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
cc: Christoph Hellwig <hch@infradead.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: [PATCH] (18/22) task_thread_info - part 2/4
In-Reply-To: <20050825144152.GU9322@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.61.0508251720150.3728@scrub.home>
References: <E1E8AEh-0005eT-NP@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.61.0508251107500.24552@scrub.home>
 <20050825130738.GQ9322@parcelfarce.linux.theplanet.co.uk>
 <20050825135933.GA14448@infradead.org> <Pine.LNX.4.61.0508251610441.3728@scrub.home>
 <20050825144152.GU9322@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 25 Aug 2005, Al Viro wrote:

> OK, fuck that.  Consider the patchbomb withdrawn.

Thanks.
Nobody is going to die that m68k doesn't compile again for another 
release. I appreciate the kick to get it going, but there is no point in 
forcing it a few days before the release, which basically leaves no other 
option than "merge now or die!".

bye, Roman
