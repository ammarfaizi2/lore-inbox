Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262611AbVE0Wpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262611AbVE0Wpo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 18:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262633AbVE0Wpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 18:45:44 -0400
Received: from fire.osdl.org ([65.172.181.4]:33183 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262611AbVE0Wpj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 18:45:39 -0400
Date: Fri, 27 May 2005 15:46:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: perex@suse.cz, linux-kernel@vger.kernel.org, git@vger.kernel.org
Subject: Re: ALSA official git repository
Message-Id: <20050527154625.5490f405.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505271502240.17402@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505271741490.1757@pnote.perex-int.cz>
	<Pine.LNX.4.58.0505270903230.17402@ppc970.osdl.org>
	<Pine.LNX.4.58.0505271941250.1757@pnote.perex-int.cz>
	<Pine.LNX.4.58.0505271113410.17402@ppc970.osdl.org>
	<20050527135124.0d98c33e.akpm@osdl.org>
	<Pine.LNX.4.58.0505271502240.17402@ppc970.osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> > which means that the algorithm for identifying the author is "the final
> > From:".
> 
> No, the algorithm is:
>  - the email author, _or_ if there is one, the top "From:" in the body.

That all assumes that the tools are smart enough to separate the email
headers from the body :(

