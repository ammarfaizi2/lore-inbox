Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262702AbSJaQoJ>; Thu, 31 Oct 2002 11:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262812AbSJaQna>; Thu, 31 Oct 2002 11:43:30 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:41701 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262702AbSJaQmI>;
	Thu, 31 Oct 2002 11:42:08 -0500
Date: Thu, 31 Oct 2002 11:48:33 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Gerd Knorr <kraxel@bytesex.org>
cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.45: initrd broken?
In-Reply-To: <20021031170340.GA18058@bytesex.org>
Message-ID: <Pine.GSO.4.21.0210311148190.16688-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 31 Oct 2002, Gerd Knorr wrote:

>   Hi,
> 
> 2.5.45 doesn't boot for me.  I'm using a initrd to load some modules.
> The last lines I see are:
> 
>   (1) RAMDISK telling me it has found a image.
>   (2) initrd is freed
>   (3) Oops.
> 
> 2.5.44 used to print it has mounted the root fs (i.e. the initrd)
> instead of oopsing.
> 
> I can hook up a serial console to grab the exact messages if needed.

Please, do.

