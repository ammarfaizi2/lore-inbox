Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265177AbUAPQLO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 11:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265209AbUAPQLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 11:11:14 -0500
Received: from mail5.bluewin.ch ([195.186.1.207]:47838 "EHLO mail5.bluewin.ch")
	by vger.kernel.org with ESMTP id S265177AbUAPQLL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 11:11:11 -0500
Date: Fri, 16 Jan 2004 17:11:26 +0100
To: Hans Ulrich Niedermann <linux-kernel@n-dimensional.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.1-rc3] Canonically reference files in Documentation/, code comments part
Message-ID: <20040116161126.GA664@mars>
References: <86ad4y70n2.fsf@n-dimensional.de> <20040108222808.GC785@mars> <86eku9m2fh.fsf@n-dimensional.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86eku9m2fh.fsf@n-dimensional.de>
User-Agent: Mutt/1.5.4i
From: a.othieno@bluewin.ch (Arthur Othieno)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 09, 2004 at 06:56:02PM +0100, Hans Ulrich Niedermann wrote:
> >> diff -Nru a/sound/oss/via82cxxx_audio.c b/sound/oss/via82cxxx_audio.c
> >> --- a/sound/oss/via82cxxx_audio.c	Thu Jan  8 18:48:58 2004
> >> +++ b/sound/oss/via82cxxx_audio.c	Thu Jan  8 18:48:58 2004
> >> @@ -10,7 +10,7 @@
> >>   * NO WARRANTY
> >>   *
> >>   * For a list of known bugs (errata) and documentation,
> >> - * see via-audio.pdf in linux/Documentation/DocBook.
> >> + * see via-audio.pdf in Documentation/DocBook.
> >>   * If this documentation does not exist, run "make pdfdocs".
> >>   */
> >
> > True only if we did `make pdfdocs'. Perhaps this should be via-audio.tmpl?
> 
> I'm just adapting references, not rewriting and correcting the text.

Sorry, didn't see the the line below that (referring to `make pdfdocs').

> Improved patch attached (one patch for both doc files and source comments).

Looks good. Great stuff.
