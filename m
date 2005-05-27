Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262043AbVE0SOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbVE0SOv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 14:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262381AbVE0SOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 14:14:51 -0400
Received: from fire.osdl.org ([65.172.181.4]:40895 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262043AbVE0SOo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 14:14:44 -0400
Date: Fri, 27 May 2005 11:16:44 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jaroslav Kysela <perex@suse.cz>
cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: ALSA official git repository
In-Reply-To: <Pine.LNX.4.58.0505271941250.1757@pnote.perex-int.cz>
Message-ID: <Pine.LNX.4.58.0505271113410.17402@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505271741490.1757@pnote.perex-int.cz>
 <Pine.LNX.4.58.0505270903230.17402@ppc970.osdl.org>
 <Pine.LNX.4.58.0505271941250.1757@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 May 2005, Jaroslav Kysela wrote:
> 
> Okay, sorry for this small bug. I'll recreate the ALSA git tree with
> proper comments again. Also, the author is not correct (should be taken
> from the first Signed-off-by:).

Hmm.. That's not always true in general, since Sign-off does allow to sign
off on other peoples patches (see the "(b)" clause in DCO), but maybe in
the ALSA tree it is.

Are you coming from a CVS tree or what? It's clearly not my patch 
applicator thing, since that one removes spaces, I'm pretty sure.

		Linus
