Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267922AbTAMFU7>; Mon, 13 Jan 2003 00:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267923AbTAMFU6>; Mon, 13 Jan 2003 00:20:58 -0500
Received: from dsl-67-48-44-237.telocity.com ([67.48.44.237]:64837 "EHLO
	lnuxlab.ath.cx") by vger.kernel.org with ESMTP id <S267922AbTAMFUe>;
	Mon, 13 Jan 2003 00:20:34 -0500
Date: Mon, 13 Jan 2003 00:47:00 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Nervous with 2.4.21-pre3 and -pre3-ac*
Message-ID: <20030113054700.GA949@lnuxlab.ath.cx>
References: <20030113052151.C4594171B7@bellini.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030113052151.C4594171B7@bellini.mit.edu>
User-Agent: Mutt/1.3.28i
From: khromy@lnuxlab.ath.cx (khromy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2003 at 12:21:51AM -0500, ghugh Song wrote:
> BTW, After several segmentation faults from a few repeated tries 
> of unsuccessful tar command, the machine got frozen.

I had the same thing happen here using 2.4.21-pre3-ac2.  cpio segfaulted
and then the machine hung.  I went back to 2.4.21-pre3 and all is well,
so far.

PIII866, 256MB RAM

Bus  0, device   7, function  1:
  IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE (rev 6).
    Master Capable.  Latency=32.  
    I/O at 0xd000 [0xd00f].

-- 
L1:	khromy		;khromy(at)lnuxlab.ath.cx
