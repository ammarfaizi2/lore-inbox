Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262478AbSJETmJ>; Sat, 5 Oct 2002 15:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262480AbSJETmJ>; Sat, 5 Oct 2002 15:42:09 -0400
Received: from modemcable166.48-200-24.mtl.mc.videotron.ca ([24.200.48.166]:13277
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S262478AbSJETln>; Sat, 5 Oct 2002 15:41:43 -0400
Date: Sat, 5 Oct 2002 15:47:09 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Ulrich Drepper <drepper@redhat.com>
cc: Larry McVoy <lm@bitmover.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: New BK License Problem?
In-Reply-To: <3D9F3C5C.1050708@redhat.com>
Message-ID: <Pine.LNX.4.44.0210051533310.5197-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Oct 2002, Ulrich Drepper wrote:

> I have never looked closer at bk than I had to be able to check out the
> latest sources.  I'm not doing any development with it and I'm not
> checking in anything using bk.

What about Larry making available a special version of BK that would only be
able to perform checkouts?  

This special version could have a less controversial license, even be GPL
with source.  This only to provide a tool to extract data out of public BK
repositories (like Linus' kernel repository) for people who don't intend or
aren't willing to actually use the real value of the full fledged BK.


Nicolas


