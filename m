Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964846AbWGYVJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbWGYVJY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 17:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964834AbWGYVJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 17:09:24 -0400
Received: from mail.gmx.de ([213.165.64.21]:25740 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964846AbWGYVJX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 17:09:23 -0400
X-Authenticated: #428038
Date: Tue, 25 Jul 2006 23:09:19 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Nathan Scott <nathans@sgi.com>, stable@kernel.org,
       Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17.[1-6] XFS Filesystem Corruption, Where is 2.6.17.7?
Message-ID: <20060725210919.GD4807@merlin.emma.line.org>
Mail-Followup-To: Nathan Scott <nathans@sgi.com>, stable@kernel.org,
	Justin Piszcz <jpiszcz@lucidpixels.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0607241224010.10896@p34.internal.lan> <20060725084624.C2090627@wobbly.melbourne.sgi.com> <20060725210716.GC4807@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060725210716.GC4807@merlin.emma.line.org>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.12 (2006-07-17)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2006, Matthias Andree wrote:

> A serious suggestion is, providing that the arguments presented (people
> busy with OLS preparations and long review queue for 2.6.17.N+1):
> 
> How about doing 2.6.17.7 as an interim release fixing just what is known
> to be critical at the point of the release, and then review the rest for
> 2.6.17.8? That would nicely fit the release early, release often - users
> like that particularly for bug fixes.

OK, 2.6.17.7 is out, but still - is this suggestion worthwhile
considering for future -stable release engineering or just crap?

-- 
Matthias Andree
