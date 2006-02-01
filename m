Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161110AbWBARBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161110AbWBARBc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 12:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161111AbWBARBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 12:01:32 -0500
Received: from mail.gmx.net ([213.165.64.21]:44443 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161110AbWBARBb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 12:01:31 -0500
X-Authenticated: #428038
Date: Wed, 1 Feb 2006 18:01:21 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: acahalan@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux try #2
Message-ID: <20060201170121.GA13559@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	acahalan@gmail.com, linux-kernel@vger.kernel.org
References: <200601302043.56615.diablod3@gmail.com> <20060130.174705.15703464.davem@davemloft.net> <Pine.LNX.4.64.0601310609210.2979@innerfire.net> <20060131.031817.85883571.davem@davemloft.net> <787b0d920601312049n313364a1q8a41e10c3cda98e0@mail.gmail.com> <43E0E37F.nail46311EZ49@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E0E37F.nail46311EZ49@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-02-01:

> > Forking means dealing with a giant pile of messy and ugly code.
> > The coding conventions are... interesting... and this code has
> > to run setuid. One had better be really careful making changes.
> > Most people are clueless about setuid code.
> 
> The original code demonstarates that suid root is not needed
> if you run on an operating system that offers the needed features (e.g. 
> Solaris).

That's old news, no need to repost this every other hour.

-- 
Matthias Andree
