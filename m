Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263423AbRFAIxK>; Fri, 1 Jun 2001 04:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263426AbRFAIxA>; Fri, 1 Jun 2001 04:53:00 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:60853 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263423AbRFAIwn>;
	Fri, 1 Jun 2001 04:52:43 -0400
Date: Fri, 1 Jun 2001 04:52:40 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Gregor Jasny <gjasny@wh8.tu-dresden.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.4 Kernel Oops and ls+rm segfaults
In-Reply-To: <01060110473400.29231@backfire>
Message-ID: <Pine.GSO.4.21.0106010451060.20420-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 1 Jun 2001, Gregor Jasny wrote:

> Hi!
> 
> Can anyone tell me, where this oops came from?
> The machine is a HP NetServer II lc (EISA+PCI architecture).
> The distribution is a slackware 7.0 with parts of 7.1 and current.
> gcc: 2.95.4 20010319 (Debian prerelease)
> 
> I hope you can help me.

Pagecache corruption somewhere.
	a) what filesystems do you have?
	b) is the thing reproducable?

