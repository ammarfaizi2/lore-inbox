Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316204AbSIIEYt>; Mon, 9 Sep 2002 00:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316408AbSIIEYt>; Mon, 9 Sep 2002 00:24:49 -0400
Received: from dsl-213-023-043-054.arcor-ip.net ([213.23.43.54]:11708 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316204AbSIIEYq>;
	Mon, 9 Sep 2002 00:24:46 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Anton Altaparmakov <aia21@cantab.net>,
       torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [BK-PATCH 1/3] Introduce fs/inode.c::ilookup().
Date: Sun, 8 Sep 2002 18:25:24 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org (Linux Kernel),
       viro@math.psu.edu (Alexander Viro)
References: <E17ngYk-00025C-00@storm.christs.cam.ac.uk>
In-Reply-To: <E17ngYk-00025C-00@storm.christs.cam.ac.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17oGD2-0006lI-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 07 September 2002 16:27, Anton Altaparmakov wrote:
> Linus,
> 
> This is the first of three patches implementing ilookup(), a function
> to search the inode cache for an inode and if not found just return NULL.
> 
> All response about ilookup() / ilookup5() was positive and several
> file systems would like to have such a function available.

Well, one person thought it should be called ifind.

-- 
Daniel

