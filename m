Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266240AbUALU7n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 15:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266239AbUALU7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 15:59:25 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:25238 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266240AbUALU7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 15:59:11 -0500
Date: Thu, 8 Jan 2004 10:29:26 +0100
From: Pavel Machek <pavel@ucw.cz>
To: James Simmons <jsimmons@infradead.org>
Cc: S Ait-Kassi <sait-kassi@zonnet.nl>, linux-kernel@vger.kernel.org
Subject: Re: [update]  Vesafb problem since 2.5.51
Message-ID: <20040108092926.GB467@openzaurus.ucw.cz>
References: <200401061440.55724.sait-kassi@zonnet.nl> <Pine.LNX.4.44.0401062305180.21143-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401062305180.21143-100000@phoenix.infradead.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Just tried the patch with the 2.6.0 kernel and it didn't help. As a bonus 
> > "feature" the cursor also makes the character it is underlining blink.
> 
> The cursor is busted but I think the latest patch from Pavel might fix it.

Unless he is using softcursor (by issuing appropriate escape
sequence), that is unlikely.
				Pavel

