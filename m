Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262363AbVCBReT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbVCBReT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 12:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbVCBReT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 12:34:19 -0500
Received: from fire.osdl.org ([65.172.181.4]:4549 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262363AbVCBReQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 12:34:16 -0500
Date: Wed, 2 Mar 2005 09:35:35 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Matthias Andree <matthias.andree@gmx.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.11
In-Reply-To: <20050302164759.GA30505@merlin.emma.line.org>
Message-ID: <Pine.LNX.4.58.0503020931360.25732@ppc970.osdl.org>
References: <Pine.LNX.4.58.0503012356480.25732@ppc970.osdl.org>
 <20050302103158.GA13485@merlin.emma.line.org> <Pine.LNX.4.58.0503020738300.25732@ppc970.osdl.org>
 <20050302164759.GA30505@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 2 Mar 2005, Matthias Andree wrote:
> 
> Is the master side a hidden host rather than ftp.kernel.org?

Yes. The private keys etc used to generate the signatures are not on the
public sites, which is what I assume your question _really_ is.

> > (In contrast the full ChangeLog was missing because the generation script
> > I use is not exactly the smart way, so it's O(slow(n)), where slow is n**3 
> > or worse, so the log from the last -rc release is fast, but going back all 
> > the way to 2.6.10 took long long enough that I didn't wait for it).
> 
> If that is an issue with the shortlog script or its integration with BK,
> contact me off-list so we can resolve the issue.

No, it's just my stupid release script.

		Linus
