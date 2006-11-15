Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932490AbWKODLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbWKODLd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 22:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932601AbWKODLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 22:11:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:22497 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932490AbWKODLc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 22:11:32 -0500
Date: Tue, 14 Nov 2006 19:10:42 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Miller <davem@davemloft.net>
cc: jeff@garzik.org, linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
In-Reply-To: <20061114.190036.30187059.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0611141909370.3349@woody.osdl.org>
References: <Pine.LNX.4.64.0611141747490.3349@woody.osdl.org>
 <455A7E21.7020701@garzik.org> <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org>
 <20061114.190036.30187059.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 14 Nov 2006, David Miller wrote:
> > 
> > I don't think "nice" is enough of an advantage to overcome "doesn't work 
> > on God knows how many systems".
> 
> From what I see, that's not the advantage of MSI.  The following
> doesn't apply so well to sound, but it does apply significantly
> to the networking.

You're totally missing the issue.

Read that sentence of mine again.

Yours was still an example of "nice". And it had absolutely nothing to do 
with the _PROBLEM_.

			Linus
