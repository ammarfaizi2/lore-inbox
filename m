Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135535AbRDXQ57>; Tue, 24 Apr 2001 12:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135549AbRDXQ5x>; Tue, 24 Apr 2001 12:57:53 -0400
Received: from [203.143.19.4] ([203.143.19.4]:57353 "EHLO kitul.learn.ac.lk")
	by vger.kernel.org with ESMTP id <S135544AbRDXQ5I>;
	Tue, 24 Apr 2001 12:57:08 -0400
Date: Tue, 24 Apr 2001 12:28:01 +0600 (LKT)
From: Anuradha Ratnaweera <anuradha@gnu.org>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: esr@thyrsus.com, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Request for comment -- a better attribution system
In-Reply-To: <200104212023.f3LKN7P188973@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.4.21.0104241227020.1519-100000@presario>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 21 Apr 2001, Albert D. Cahalan wrote:

> Eric S. Raymond writes:
> 
> > This is a proposal for an attribution metadata system in the Linux
> > kernel sources.  The goal of the system is to make it easy for
> > people reading any given piece of code to identify the responsible
> > maintainer.  The motivation for this proposal is that the present
> > system, a single top-level MAINTAINERS file, doesn't seem to be
> > scaling well.
> 
> It is nice to have a single file for grep. With the proposed
> changes one would sometimes need to grep every file.

What about

grep `find . -name "MAINTAINERS"`

Anuradha


