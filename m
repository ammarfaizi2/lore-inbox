Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270671AbTGUTXF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 15:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270673AbTGUTXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 15:23:05 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:41110 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S270671AbTGUTXA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 15:23:00 -0400
Date: Mon, 21 Jul 2003 21:37:48 +0200
From: Pavel Machek <pavel@ucw.cz>
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel@vger.kernel.org, vojtech@ucw.cz
Subject: Re: 2.6.0: characters repeated when *pasting*?!
Message-ID: <20030721193748.GC436@elf.ucw.cz>
References: <200307210928.h6L9SUfx000613@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307210928.h6L9SUfx000613@81-2-122-30.bradfords.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I copied text ole.rohne@cern.ch (using gpm), pasted it to emacs (right
> > mouse button) in another console and it came out as
> > oooooole.rohne@cern.ch. That looks extremely weird and suggests that
> > repeated characters are indeed software problem.
> >
> > Its not reproducible, and nothing interesting in logs :-(.
> 
> Hmmm, are you sure you hadn't pressed meta-6 before pasting it in?

I can't be sure... I do not think I pressed that, but it certainly is
possible that I wanted to switch consoles and pressed that by mistake.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
