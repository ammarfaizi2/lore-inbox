Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316770AbSGVLZo>; Mon, 22 Jul 2002 07:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316768AbSGVLZo>; Mon, 22 Jul 2002 07:25:44 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:19965 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316770AbSGVLZm>; Mon, 22 Jul 2002 07:25:42 -0400
Subject: Re: PATCH: 2.5.27 port thunderlan to the new DMA API
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nicholas Miell <nmiell@attbi.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, davej@suse.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <1027317081.1092.3.camel@entropy>
References: <E17WN0K-0007Yb-00@the-village.bc.nu> 
	<1027317081.1092.3.camel@entropy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 22 Jul 2002 13:41:21 +0100
Message-Id: <1027341682.31782.13.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-22 at 06:51, Nicholas Miell wrote:
> On Sun, 2002-07-21 at 13:08, Alan Cox wrote:
> > Tested and running on my Compaq both in bbuf and direct mode.
> > 
> 
> I need this to compile, which leads me to believe that perhaps that
> wasn't your final patch...

The _ change was the only change missing so yes - Linus this extra diff
is correct

