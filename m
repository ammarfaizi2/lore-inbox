Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280042AbRKDR2I>; Sun, 4 Nov 2001 12:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280037AbRKDR2B>; Sun, 4 Nov 2001 12:28:01 -0500
Received: from humbolt.nl.linux.org ([131.211.28.48]:8341 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S281053AbRKDR1n>; Sun, 4 Nov 2001 12:27:43 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Tim Jansen <tim@tjansen.de>,
        Jakob =?iso-8859-1?q?=D8stergaard?= <jakob@unthought.net>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Date: Sun, 4 Nov 2001 18:28:47 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15zF9H-0000NL-00@wagner> <20011104163354.C14001@unthought.net> <160QM5-1HAz5sC@fmrl00.sul.t-online.com>
In-Reply-To: <160QM5-1HAz5sC@fmrl00.sul.t-online.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011104172742Z16629-26013+37@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 4, 2001 05:45 pm, Tim Jansen wrote:
> > The dot-proc file is basically a binary encoding of Lisp (or XML), e.g. it
> > is a list of elements, wherein an element can itself be a list (or a
> 
> Why would anybody want a binary encoding? 

Because they have a computer?

> It needs special parsers and will be almost impossible to access from shell 
> scripts. 

No, look, he's proposing to put the binary encoding in hidden .files.  The 
good old /proc files will continue to appear and operate as they do now.

--
Daniel
