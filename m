Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262206AbVG1R5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262206AbVG1R5G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 13:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbVG1R5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 13:57:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27099 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262150AbVG1R47 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 13:56:59 -0400
Date: Thu, 28 Jul 2005 10:55:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Radoslaw "AstralStorm" Szkodzinski <astralstorm@gorzow.mm.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm3 question
Message-Id: <20050728105551.57f3183c.akpm@osdl.org>
In-Reply-To: <20050728194334.4f5b3f22.astralstorm@gorzow.mm.pl>
References: <20050728194334.4f5b3f22.astralstorm@gorzow.mm.pl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Radoslaw "AstralStorm" Szkodzinski <astralstorm@gorzow.mm.pl> wrote:
>
> I wonder which git version is linus.patch updating to, as it certainly isn't
> the mostly new git/hg tree (sans ALSA tree merge), as one patch didn't apply cleanly.

It's there in the patch?

bix:/usr/src/25> head patches/linus.patch 
GIT 41c018b7ecb60b1c2c4d5dee0cd37d32a94c45af master.kernel.org:/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

> (sched-consider-migration-thread-with-smp-nice.patch)
> It could be written as a comment, if that's not too hard to do.
> 
> What about releasing a secret release just right before -mm in order to avoid
> problems like that MTRR problem?

There are always glitches, I'm afraid.
