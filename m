Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281568AbRKPVrW>; Fri, 16 Nov 2001 16:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281565AbRKPVrQ>; Fri, 16 Nov 2001 16:47:16 -0500
Received: from ns.suse.de ([213.95.15.193]:7186 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S281566AbRKPVq1>;
	Fri, 16 Nov 2001 16:46:27 -0500
Date: Fri, 16 Nov 2001 22:46:26 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] AMD SMP capability sanity checking.
In-Reply-To: <3BF587F8.84607648@osdl.org>
Message-ID: <Pine.LNX.4.30.0111162245080.22827-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2001, Randy.Dunlap wrote:

> Dave-
> A couple of minor comments below.
> Some bit #defines for <tainted> would be nice (instead of magic
> numbers).

Agreed.

> >                 snprintf(buf, sizeof(buf), "Tainted: %c%c",
> >>>>>>>>>>>>>>>>>>                                     %c%c%c <<<<<<<<<<<<<

Yup. Thanks for that.

Those fixes, plus fixing borken indentation I introduced will be in
-2 at http://www.codemonkey.org.uk/cruft/
in a while.

regards,

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

