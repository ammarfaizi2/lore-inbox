Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287341AbRL3Fl4>; Sun, 30 Dec 2001 00:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287343AbRL3Flq>; Sun, 30 Dec 2001 00:41:46 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:1288 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S287341AbRL3Flg>; Sun, 30 Dec 2001 00:41:36 -0500
Date: Sat, 29 Dec 2001 21:39:34 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: CJ <cj@cjcj.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Dave Jones <davej@codemonkey.org.uk>,
        Trond Myklebust <trond.myklebust@fys.uio.no>,
        Dave Jones <davej@suse.de>, Chuck Lever <cel@monkey.org>
Subject: Re: Possible O_DIRECT problems ?
In-Reply-To: <3C2E0F6C.30608@cjcj.com>
Message-ID: <Pine.LNX.4.10.10112292138250.32522-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Dec 2001, CJ wrote:

> Shouldn't O_DIRECT's requirements come from the hardware?  If we can 
> ASPI or CAM DMA SCSI devices to odd addresses and lengths, why not 
> O_DIRECT?  Do ape drives DMA to user buffers?  Are O_DIRECT's 
> current limits gratuitous?

CAM is a very bad thing and that is why the X3 committees split.


Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

