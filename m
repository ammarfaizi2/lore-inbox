Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281473AbRLLRaY>; Wed, 12 Dec 2001 12:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281512AbRLLRaP>; Wed, 12 Dec 2001 12:30:15 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22799 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S281473AbRLLRaB>; Wed, 12 Dec 2001 12:30:01 -0500
Date: Wed, 12 Dec 2001 17:29:21 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Tyler BIRD <BIRDTY@uvsc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS woes in 2.5.1-pre8
Message-ID: <20011212172921.C16377@flint.arm.linux.org.uk>
In-Reply-To: <sc172fdb.089@mail-smtp.uvsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <sc172fdb.089@mail-smtp.uvsc.edu>; from BIRDTY@uvsc.edu on Wed, Dec 12, 2001 at 10:22:04AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2001 at 10:22:04AM -0700, Tyler BIRD wrote:
> Search the kernel sources at: http://lxr.linux.no/source/kernel/?v=2.4.13 or 2.4.26, etc
> I know the ip addres for each interface are stored somewhere.
> They have to be because they are passed down to the net driver inside of  socket buffers ( skb )
> as a struct tcphdr *  and they have to be appended to each packet.

Sorry, I don't see what this has to do with my NFS problem.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

