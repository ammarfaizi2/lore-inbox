Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbTIZVtW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 17:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbTIZVtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 17:49:22 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:19962 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261645AbTIZVtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 17:49:21 -0400
Date: Fri, 26 Sep 2003 23:49:11 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: John Cherry <cherry@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: IA32 - 6 New warnings (gcc 3.2.2)
Message-ID: <20030926214911.GC2881@fs.tum.de>
References: <200309260548.h8Q5mZt3015714@cherrypit.pdx.osdl.net> <20030926155654.GO15696@fs.tum.de> <1064608625.10304.52.camel@cherrytest.pdx.osdl.net> <1064610791.10304.75.camel@cherrytest.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1064610791.10304.75.camel@cherrytest.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 26, 2003 at 02:13:12PM -0700, John Cherry wrote:
>...
> The bug is that linux/sisfb.h should be video/sisfb.h on line 37 of
> sis_m.c.  The latest linus bk tree and mm kernel seem to have it right.
> The snapshot for this build last night must have been between
> changesets.
>...

Ah, thanks for the explanations and sorry for the noise.

> John
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

