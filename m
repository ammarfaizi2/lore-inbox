Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263777AbTH3NPs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 09:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbTH3NPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 09:15:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39815 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263777AbTH3NPr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 09:15:47 -0400
Date: Sat, 30 Aug 2003 14:15:41 +0100
From: Matthew Wilcox <willy@debian.org>
To: Ruediger Scholz <rscholz@hrzpub.tu-darmstadt.de>
Cc: parisc-linux@lists.parisc-linux.org, linux-kernel@vger.kernel.org
Subject: Re: [parisc-linux] Security Hole in binfmt_som.c ?
Message-ID: <20030830131541.GI13467@parcelfarce.linux.theplanet.co.uk>
References: <3F509BBD.2040007@hrzpub.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F509BBD.2040007@hrzpub.tu-darmstadt.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 30, 2003 at 02:42:37PM +0200, Ruediger Scholz wrote:
> binfmt_som.c:216:2: #error "Fix security hole before enabling me"
> What's this message about?

I don't know.  I wish someone would tell me.  You'd think they'd have the
decency to contact the person listed as the author at the top of the file.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
