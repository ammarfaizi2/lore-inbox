Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265125AbTFYXnm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 19:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265128AbTFYXnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 19:43:42 -0400
Received: from 25.mdrx.com ([65.67.58.25]:60587 "EHLO duallie.mdrx.com")
	by vger.kernel.org with ESMTP id S265125AbTFYXnl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 19:43:41 -0400
From: Brian Jackson <brian@brianandsara.net>
To: Orion Poplawski <orion@cora.nwra.com>, linux-kernel@vger.kernel.org
Subject: Re: Is their an explanation of various kernel versions/brances/patches/? (-mm, -ck, ..)
Date: Wed, 25 Jun 2003 18:57:48 -0500
User-Agent: KMail/1.5.2
References: <bdd64m$3dr$1@main.gmane.org>
In-Reply-To: <bdd64m$3dr$1@main.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200306251857.48341.brian@brianandsara.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know of a website that tracks that stuff, but here goes my knowledge 
of the different patchsets:

for the most part all of them are testing grounds for patches that someday 
hope to be in the vanilla kernel

mm - Andrew Morton - vm related testing ground for dev tree
ck - Con Kolivas - desktop/interactivity patches
kj - Kernel Janitors - testing ground for kernel cleanups on development trees
mjb - Martin J Bligh - scalability stuff
wli - William Lee Irwin - other vm related stuff for dev tree that Andrew
	Morton may not have time for
ac - Alan Cox - lately it's been a testing ground for new ide
lsm - Chris Wright - Linux Security Modules, provides a lightweight, general
	purpose framework for access control
osdl - Stephen Hemminger, ? maybe enterprise stuff
laptop - Hanno Böck - unproven laptop type patches
aa - Andrea Arcangeli - stable series vm stuff
dj - Dave Jones - cleanups/AGP
rmap - Rik van Riel - reverse mapping vm for 2.4
pgcl - William Lee Irwin - ?

Others? Oh yes. Maybe this is something that should be tracked on a webpage 
somewhere.

--Brian Jackson

On Wednesday 25 June 2003 05:02 pm, Orion Poplawski wrote:
> Seems like everybody and their brother is maintaining a kernel patch set
> these days :-).
>
> Is there a page somewhere that explains the goals of each of the various
> versions?
>
> Thanks!
>
> - Orion
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
OpenGFS -- http://opengfs.sourceforge.net
Home -- http://www.brianandsara.net

