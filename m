Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284751AbRLKAEO>; Mon, 10 Dec 2001 19:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284756AbRLKAEF>; Mon, 10 Dec 2001 19:04:05 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:27242 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S284751AbRLKADt>; Mon, 10 Dec 2001 19:03:49 -0500
Date: Tue, 11 Dec 2001 01:02:23 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Abraham vd Merwe <abraham@2d3d.co.za>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.16 & OOM killer screw up
Message-ID: <20011211010223.Z4801@athlon.random>
In-Reply-To: <20011210101452.F1502@crystal.2d3d.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011210101452.F1502@crystal.2d3d.co.za>; from abraham@2d3d.co.za on Mon, Dec 10, 2001 at 10:14:52AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2001 at 10:14:52AM +0200, Abraham vd Merwe wrote:
> Hi!
> 
> If I leave my machine on for a day or two without doing anything on it (e.g.
> my machine at work over a weekend) and I come back then 1) all my memory is
> used for buffers/caches and when I try running application, the OOM killer
> kicks in, tries to allocate swap space (which I don't have) and kills
> whatever I try start (that's with 300M+ memory in buffers/caches).

I'd try 2.4.17pre4aa1.

Andrea
