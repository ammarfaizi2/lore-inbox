Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263414AbREXIkd>; Thu, 24 May 2001 04:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263417AbREXIkX>; Thu, 24 May 2001 04:40:23 -0400
Received: from www.wen-online.de ([212.223.88.39]:10258 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S263414AbREXIkM>;
	Thu, 24 May 2001 04:40:12 -0400
Date: Thu, 24 May 2001 07:32:39 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Alexander Viro <viro@math.psu.edu>
cc: Maciek Nowacki <maciek@Voyager.powersurfr.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Busy on BLKFLSBUF w/initrd
In-Reply-To: <Pine.GSO.4.21.0105231753270.20269-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0105240729330.461-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 May 2001, Alexander Viro wrote:

> Folks, who the hell is responsible for rd_inodes[] idiocy?

That would have been me.  It was simple and needed at the time..
feel free to rip it up :)

	-Mike

