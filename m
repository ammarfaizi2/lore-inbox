Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbTICE7H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 00:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262372AbTICE7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 00:59:07 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:50183 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S262133AbTICE7F convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 00:59:05 -0400
Date: Wed, 3 Sep 2003 06:50:32 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Will L G <diskman@kc.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compressed VMLINUX Kernel
Message-ID: <20030903045032.GB24145@alpha.home.local>
References: <004801c371c1$fc64b0f0$6501a8c0@zephyr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <004801c371c1$fc64b0f0$6501a8c0@zephyr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 02, 2003 at 09:20:46PM -0500, Will L G wrote:
> I was wondering, is there some method or utility that will allow me to
> compress my kernel (vmlinux)? I was running an alpha and bzImage and zImage
> don’t work.  I read all the mans that I could lay my grubby little hands on
> but none of them mentioned HOW one is the compress a vmlinux kernel.  
>  
> The reason ask this is, I boot to linux using an OLD IDE drive and it takes
> sometime to read a 7mb file. I noticed that the original kernel
> (Redhat/Compaq derivative) was compressed and somewhat smaller, about less
> than half the size. Thanks, Will L G
>  

I'm pretty sure I already booted mine with a vmlinux.gz kernel which simply was
a gzip applied to a normal vmlinux image.

Regards,
willy
