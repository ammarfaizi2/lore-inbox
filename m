Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268321AbUIKVC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268321AbUIKVC4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 17:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268326AbUIKVCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 17:02:55 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:58518 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268321AbUIKVCk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 17:02:40 -0400
Message-ID: <9e4733910409111402138737aa@mail.gmail.com>
Date: Sat, 11 Sep 2004 17:02:36 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: radeon-pre-2
Cc: Christoph Hellwig <hch@infradead.org>, Dave Airlie <airlied@linux.ie>,
       =?ISO-8859-1?Q?Felix_K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0409111058320.2341@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e47339104090919015b5b5a4d@mail.gmail.com>
	 <9e47339104091010221f03ec06@mail.gmail.com>
	 <1094835846.17932.11.camel@localhost.localdomain>
	 <9e47339104091011402e8341d0@mail.gmail.com>
	 <Pine.LNX.4.58.0409102254250.13921@skynet>
	 <20040911132727.A1783@infradead.org>
	 <9e47339104091109111c46db54@mail.gmail.com>
	 <Pine.LNX.4.58.0409110939200.2341@ppc970.osdl.org>
	 <9e473391040911105448c3f089@mail.gmail.com>
	 <Pine.LNX.4.58.0409111058320.2341@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan, if you will commit Redhat to implementing all of the features
referenced in this message:
http://lkml.org/lkml/2004/8/2/111
then I'll back off and go work on the X server.

Use whatever mechanism you want, but implement all of the features. 

There are two main goals:

#1) Get mesa-solo running with superbuffers, this means memory
allocation and mode setting have to be fixed. This will be the base
platform for X on GL.

#2) Support independent users logged into each head. One using the
console with fbdev and the other X and a 3D game.

-- 
Jon Smirl
jonsmirl@gmail.com
