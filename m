Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266877AbUGLQoS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266877AbUGLQoS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 12:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266887AbUGLQoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 12:44:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:59281 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266877AbUGLQoQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 12:44:16 -0400
Date: Mon, 12 Jul 2004 09:43:54 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.8-rc1
In-Reply-To: <20040712163417.GT4701@fs.tum.de>
Message-ID: <Pine.LNX.4.58.0407120940360.1764@ppc970.osdl.org>
References: <Pine.LNX.4.58.0407111120010.1764@ppc970.osdl.org>
 <4d8e3fd3040712023469039826@mail.gmail.com> <20040712154204.GS4701@fs.tum.de>
 <4d8e3fd304071208566280e89b@mail.gmail.com> <20040712163417.GT4701@fs.tum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 12 Jul 2004, Adrian Bunk wrote:
> 
> The Linux kernel development process isn't that much formalized. But if 
> someone finds a serious new problem in a -rc kernel a fix will usually 
> go into the next -rc.

Indeed.

The whole _point_ of -rc kernels is to find silly problems. 

Trying to have a release mechanism for -rc kernels in order to avoid some 
problems in them would kind of defeat the point. The -rc kernels are there 
to encourage people who wouldn't want to just take a daily shapshot to 
tell us when we break things - and clearly it's working ;)

(There's also a totally nontechnical point to -rc kernels: it's a way to 
tell people to calm down a bit. Usually we have a backlog that gets filled 
up after a kernel release, and then with the -rc kernels people usually 
slow down feeding non-critical stuff to me. At least a bit)

		Linus
