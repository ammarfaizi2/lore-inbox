Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266965AbSKQWEU>; Sun, 17 Nov 2002 17:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266967AbSKQWEU>; Sun, 17 Nov 2002 17:04:20 -0500
Received: from [209.195.52.121] ([209.195.52.121]:44791 "HELO
	warden2b.diginsite.com") by vger.kernel.org with SMTP
	id <S266965AbSKQWET>; Sun, 17 Nov 2002 17:04:19 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Brad Hards <bhards@bigpond.net.au>
Cc: ebiederm@xmission.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Sun, 17 Nov 2002 14:00:38 -0800 (PST)
Subject: Re: lan based kgdb
In-Reply-To: <200211180848.40509.bhards@bigpond.net.au>
Message-ID: <Pine.LNX.4.44.0211171359050.10200-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2002, Brad Hards wrote:

> On Mon, 18 Nov 2002 08:32, David Lang wrote:
> > a couple quick questions from an end-user
> >
> > 1. will an interface be dedicated to this use, or will it share an
> > interface with other traffic.
> I imagined that it would have to be shared. The world is not a PC, and you
> can't trivially add extra connectivtity to that embedded ARM board...

I can see that, it will add more complexity thought

> <snip>
> > as someone managing 60 or so remote boxes, this sounds really nice, if it
> > can be made to work securely.
> OK, I'm confused again. Do you want remote, or to you want link-local?

I want link-local. as has been discused once you have two boxes in one
location link-local is good enough and I always deploy boxes in HA pairs

David Lang

