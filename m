Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262850AbSJ1E2Z>; Sun, 27 Oct 2002 23:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262865AbSJ1E2Z>; Sun, 27 Oct 2002 23:28:25 -0500
Received: from marc2.theaimsgroup.com ([63.238.77.172]:41744 "EHLO
	marc2.theaimsgroup.com") by vger.kernel.org with ESMTP
	id <S262850AbSJ1E2Y>; Sun, 27 Oct 2002 23:28:24 -0500
Date: Sun, 27 Oct 2002 23:34:42 -0500
Message-Id: <200210280434.g9S4Ygh13812@marc2.theaimsgroup.com>
From: Hank Leininger <linux-kernel@progressive-comp.com>
Reply-To: Hank Leininger <hlein@progressive-comp.com>
To: linux-kernel@vger.kernel.org
Subject: Re: ARGH!  (Is there an HTML archive for linux-kernel that patches work from?)
X-Shameless-Plug: Check out http://marc.theaimsgroup.com/
X-Warning: This mail posted via a web gateway at marc.theaimsgroup.com
X-Warning: Report any violation of list policy to abuse@progressive-comp.com
X-Posted-By: Hank Leininger <hlein@progressive-comp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-10-27, Rob Landley <landley@trommello.org> wrote:

> Marc.theaimsgroup.com has a lovely "raw mode", but it truncates posts
> that are too long.

This is true, and I consider it a bug.  However the limit should be quite
high--either 256KB or 1MB or so.  So raising / eliminating the limit isn't
high on my priority list :-P  Please do let us know (me directly, or
webguy@theaimsgroup.com) if you find other mails that have been truncated
at shorter than this, I'll look into it.

Also, I'm interested in any corner cases where the attachment-parser messes
up--most of all when it fails to make attachments properly downloadable,
but also, to a lesser extent, any predictably readable mime-type, encoding,
etc which it currently doesn't try to print in-line, but could.

> Erich: Could you put your october 25 numa scheduler posting on your
> home page somewhere?  I tried:

> http://home.arcor.de/efocht/patches/01-numa_sched_core-2.5.44-10a.patch

If I've got the right mail, you're after this one, correct?

http://marc.theaimsgroup.com/?l=linux-kernel&m=103556765829589&w=2

...Which looks complete from here?  That particular patch can be downloaded
directly as:

http://marc.theaimsgroup.com/?l=linux-kernel&m=103556765829589&q=p3

Thanks,

Hank Leininger <hlein@progressive-comp.com>
