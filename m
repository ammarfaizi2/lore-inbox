Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263077AbUKZX1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263077AbUKZX1H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 18:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263190AbUKZTrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:47:31 -0500
Received: from zeus.kernel.org ([204.152.189.113]:65474 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262397AbUKZT1I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:27:08 -0500
Date: Fri, 26 Nov 2004 00:56:22 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 49/51: Checksumming
Message-ID: <20041125235622.GI2909@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101300589.5805.392.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101300589.5805.392.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> A plugin for verifying the consistency of an image. Working with kdb, it
> can look up the locations of variations. There will always be some
> variations shown, simply because we're touching memory before we get
> here and as we check the image.

Debugging code, can live as external patch pretty well.
									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
