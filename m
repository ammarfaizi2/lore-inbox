Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274951AbRJALkv>; Mon, 1 Oct 2001 07:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274966AbRJALkl>; Mon, 1 Oct 2001 07:40:41 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:34246 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S274963AbRJALk3>;
	Mon, 1 Oct 2001 07:40:29 -0400
Date: Mon, 1 Oct 2001 07:40:56 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: [CFT][PATCH] cleanup of partition code
In-Reply-To: <Pine.GSO.4.21.0109302152260.13829-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0110010716590.15309-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Update:  acorn-style partitions seem to be working now, fixed an idiotic
bug in read_dev_sector() (error recovery path), did initial backport to -ac.

Patch is on ftp.math.psu.edu/pub/viro/partition-d-S11-pre1,
-ac variant is on ftp.math.psu.edu/pub/viro/partition-a-AC10-1.

