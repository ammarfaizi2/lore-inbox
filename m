Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262744AbSJHBCY>; Mon, 7 Oct 2002 21:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263143AbSJHBCY>; Mon, 7 Oct 2002 21:02:24 -0400
Received: from air-2.osdl.org ([65.172.181.6]:39080 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S262744AbSJHBCW>;
	Mon, 7 Oct 2002 21:02:22 -0400
Date: Mon, 7 Oct 2002 18:10:24 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [bk/patch] Rename driverfs to kfs
In-Reply-To: <ant9g7$1mt$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.44.0210071806500.16276-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 7 Oct 2002, H. Peter Anvin wrote:

> Followup to:  <Pine.LNX.4.44.0210071701460.16276-100000@cherise.pdx.osdl.net>
> By author:    Patrick Mochel <mochel@osdl.org>
> In newsgroup: linux.dev.kernel
> > 
> > It's the incredible mutable filesystem. As was talked about at the Kernel
> > Summit in Ottawa, and as has been threatened in the past three months,
> > here is the patch to rename driverfs to kfs. 
> > 
> 
> I'd prefer calling it kernelfs or kernfs.  [a-z]fs is a bit too busy a
> namespace.

I personally like kfs, though I agree that the namespace is busy:

bfs/
efs/
hfs/
jfs/
nfs/
ufs/
xfs/

Does Linus have an opinion? He apparently doesn't love me anymore, so I'm 
not sure that he's even paying attention, or he still agrees with the 
change..

	-pat

