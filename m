Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263102AbTKPRkT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 12:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbTKPRkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 12:40:19 -0500
Received: from mail3.ithnet.com ([217.64.64.7]:25019 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S263102AbTKPRkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 12:40:14 -0500
X-Sender-Authentication: net64
Date: Sun, 16 Nov 2003 18:40:12 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Valdis.Kletnieks@vt.edu
Cc: pavel@ucw.cz, mfedyk@matchmail.com, reiser@namesys.com,
       herbert@gondor.apana.org.au, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Debian Kernels was: 2.6.0test9 Reiserfs boot time "buffer layer
 error at fs/buffer.c:431"
Message-Id: <20031116184012.5d9f4c12.skraw@ithnet.com>
In-Reply-To: <200311161727.hAGHRbLa028984@turing-police.cc.vt.edu>
References: <20031029141931.6c4ebdb5.akpm@osdl.org>
	<E1AGCUJ-00016g-00@gondolin.me.apana.org.au>
	<20031101233354.1f566c80.akpm@osdl.org>
	<20031102092723.GA4964@gondor.apana.org.au>
	<20031102014011.09001c81.akpm@osdl.org>
	<20031116130558.GB199@elf.ucw.cz>
	<20031116170509.GB201@elf.ucw.cz>
	<200311161727.hAGHRbLa028984@turing-police.cc.vt.edu>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Nov 2003 12:27:36 -0500
Valdis.Kletnieks@vt.edu wrote:

> On Sun, 16 Nov 2003 18:05:09 +0100, Pavel Machek said:
> 
> > Okay, in the perfect world we'd have just one distribution with all
> > packages unmodified. Well.. but we are not there yet.
> 
> Then why do we have a -mm kernel and a -ac kernel and a.....?
> 
> It's interesting that we've apparently decided that Andrew Morton or
> Alan Cox or any of the other -initial kernel streams are allowed to have
> different goals (and thus different code to achieve those goals) but
> we seem to think that distributions are not allowed to do the same thing...

There is quite a simple difference in -XX kernel and a distro-patch. People
have to actively decide to use some patched kernel for whatever their reason
may be. A distro on the other hand floods the average user with patched
versions _without_ the users' active decision.
Please keep in mind that a lot of users are not capable of compiling/installing
a new kernel. Those who are have a free decision, those who are not have simply
no choice.
 
> -exec-shield is OK if it shows up in Andrew's stuff, but not when it's
> in the RedHat from whence it came?  What's wrong with THAT?

s.a.

Regards,
Stephan
