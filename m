Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130953AbRCJH5Y>; Sat, 10 Mar 2001 02:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130958AbRCJH5P>; Sat, 10 Mar 2001 02:57:15 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:55938 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130953AbRCJH46>;
	Sat, 10 Mar 2001 02:56:58 -0500
Date: Sat, 10 Mar 2001 02:56:17 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Daniel Phillips <phillips@innominate.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Directory index for Ext2 - the pagecache version
In-Reply-To: <Pine.GSO.4.21.0103092200520.17677-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0103100252480.18540-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Variant with saner locking is in the same place, called
ext2-dir-patch-b-S2.gz (no hash stuff, just an update of my part)
Comments?
						Cheers,
							Al

