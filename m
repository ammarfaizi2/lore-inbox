Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262031AbSI3MA3>; Mon, 30 Sep 2002 08:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262033AbSI3MA3>; Mon, 30 Sep 2002 08:00:29 -0400
Received: from goliath.sylaba.poznan.pl ([195.216.104.3]:11997 "EHLO
	goliath.sylaba.poznan.pl") by vger.kernel.org with ESMTP
	id <S262034AbSI3MA2>; Mon, 30 Sep 2002 08:00:28 -0400
Subject: RE: block size in XFS = hard coded constant?
From: Olaf =?iso-8859-2?Q?Fr=B1czyk?= <olaf@cbk.poznan.pl>
To: L A Walsh <law@tlinx.org>
Cc: Stephen Lord <lord@sgi.com>, Linux-Xfs <linux-xfs@oss.sgi.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
In-Reply-To: <NFBBKNPJLGIDJFAHGKMBIEIJCDAA.law@tlinx.org>
References: <NFBBKNPJLGIDJFAHGKMBIEIJCDAA.law@tlinx.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-4) 
Date: 30 Sep 2002 14:07:57 +0200
Message-Id: <1033387679.3719.5.camel@venus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-30 at 10:55, L A Walsh wrote:
> Right -- I know it isn't the filesystem block size.
> 
> In this day and age, it seems anachronistic.  Given the 10% higher block
> density, not only would it yield higher capacities, but should yield higher
> transfer rates, no?
> 
> I know it isn't a simple constant switch -- but I wouldn't want to switch
> constants since not all disks should be constrained to the same block size.
> 
> Do other file systems have the same limitation?  Are there any problems in the
> linux-kernel with non-512 byte blocks?
Hi, 

DVD-RAM (2048 bytes block size) works well in linux.
I use ext2 for DVD-RAM.

Regards,

Olaf Fraczyk




