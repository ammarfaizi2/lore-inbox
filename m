Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280954AbRKCNge>; Sat, 3 Nov 2001 08:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280955AbRKCNgY>; Sat, 3 Nov 2001 08:36:24 -0500
Received: from ns.suse.de ([213.95.15.193]:33033 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S280954AbRKCNgS>;
	Sat, 3 Nov 2001 08:36:18 -0500
Date: Sat, 3 Nov 2001 14:36:02 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: <Telford002@aol.com>
Cc: <tim@tjansen.de>, <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 PROPOSAL: Replacement for current /proc of shit.
In-Reply-To: <86.1204971d.291545b9@aol.com>
Message-ID: <Pine.LNX.4.30.0111031433260.28761-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Nov 2001 Telford002@aol.com wrote:

> >  solution: keep the type information out of the proc filesystem and save it
> >  in a file similar to Configure.help, together with a description for a
> file.
> It would always be possible to build a front end to the /proc file
> system.

The approach taken by powertweak (http://www..powertweak.org) was to
use an XML description of /proc to define types etc. It's worked out
quite well, and has the added advantage of being buzzword compliant 8)

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

