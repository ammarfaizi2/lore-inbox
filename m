Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129159AbRBZVom>; Mon, 26 Feb 2001 16:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129165AbRBZVoc>; Mon, 26 Feb 2001 16:44:32 -0500
Received: from modemcable248.137-200-24.mtl.mc.videotron.ca ([24.200.137.248]:41205
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S129159AbRBZVoV>; Mon, 26 Feb 2001 16:44:21 -0500
Date: Mon, 26 Feb 2001 16:44:11 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: ramfs causes system hang when swapping
In-Reply-To: <E14XV2q-0001zj-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0102261642190.8495-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 26 Feb 2001, Alan Cox wrote:

> RAMfs doesnt use swap. It also in 2.4.2 doesnt have limits. The -ac one uses
> limits so will stop you totally running the box out of ram. 2.4ac also has
> the true tmpfs with swap backing

Which one of those should be the best to use when there is no swap?


Nicolas

