Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265910AbUFOUEB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265910AbUFOUEB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 16:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265906AbUFOUEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 16:04:00 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:35716 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S265910AbUFOUDl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 16:03:41 -0400
Date: Tue, 15 Jun 2004 22:12:48 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Tom Rini <trini@kernel.crashing.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 0/5] kbuild
Message-ID: <20040615201248.GH2310@mars.ravnborg.org>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>, Wolfgang Denk <wd@denx.de>
References: <20040614204029.GA15243@mars.ravnborg.org> <20040615154136.GD11113@smtp.west.cox.net> <20040615174929.GB2310@mars.ravnborg.org> <20040615190951.C7666@flint.arm.linux.org.uk> <20040615191418.GD2310@mars.ravnborg.org> <20040615204616.E7666@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040615204616.E7666@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 08:46:16PM +0100, Russell King wrote:
> 
> > Maybe Wolgang can jump in here - I do not know why mkimage is needed.
> > But I do like to have it present for convinience.
> > It is btw called mkuboot.sh in scripts/ to better say what it does.
> 
> I'll let you read mkuboot.sh - you'll find that it's just a wrapper
> script to moan if you use mkuboot.sh and you don't have mkimage
> installed.
> 
> I've no idea what mkimage actually does, but from the scant comments
> in mkuboot.sh, it seems to package up into a "U-Boot image".

I know. I objected to the mkimage name in the past for a script in scripts/
for the same reasons as you outline.

	Sam
