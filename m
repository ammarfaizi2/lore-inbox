Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262927AbUGLUem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbUGLUem (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 16:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262772AbUGLUcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 16:32:55 -0400
Received: from mproxy.gmail.com ([216.239.56.250]:4598 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S262730AbUGLU2c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 16:28:32 -0400
Message-ID: <4d8e3fd304071213287b995ae9@mail.gmail.com>
Date: Mon, 12 Jul 2004 22:28:18 +0200
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux 2.6.8-rc1
Cc: Adrian Bunk <bunk@fs.tum.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0407120940360.1764@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0407111120010.1764@ppc970.osdl.org>
 <4d8e3fd3040712023469039826@mail.gmail.com> <20040712154204.GS4701@fs.tum.de>
 <4d8e3fd304071208566280e89b@mail.gmail.com> <20040712163417.GT4701@fs.tum.de> <Pine.LNX.4.58.0407120940360.1764@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jul 2004 09:43:54 -0700 (PDT), Linus Torvalds
<torvalds@osdl.org> wrote:
> 
> 
> On Mon, 12 Jul 2004, Adrian Bunk wrote:
> >
> > The Linux kernel development process isn't that much formalized. But if
> > someone finds a serious new problem in a -rc kernel a fix will usually
> > go into the next -rc.
> 
> Indeed.
> 
> The whole _point_ of -rc kernels is to find silly problems.
> 
> Trying to have a release mechanism for -rc kernels in order to avoid some
> problems in them would kind of defeat the point. The -rc kernels are there
> to encourage people who wouldn't want to just take a daily shapshot to
> tell us when we break things - and clearly it's working ;)

Again, I'm really not saying that is not working ;-),
I just think that the process could be improved using the tools we
already have available.
 
> (There's also a totally nontechnical point to -rc kernels: it's a way to
> tell people to calm down a bit. Usually we have a backlog that gets filled
> up after a kernel release, and then with the -rc kernels people usually
> slow down feeding non-critical stuff to me. At least a bit)
> 


-- 
paoloc.doesntexist.org
