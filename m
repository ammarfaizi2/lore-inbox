Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030309AbVIVNIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030309AbVIVNIl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 09:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030306AbVIVNIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 09:08:41 -0400
Received: from chiark.greenend.org.uk ([193.201.200.170]:63155 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S1030303AbVIVNIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 09:08:40 -0400
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Joshua Kwan <joshk@triplehelix.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: SATA suspend-to-ram patch - merge?
In-Reply-To: <4332ABDC.3030106@rtr.ca>
References: <433104E0.4090308@triplehelix.org> <433221A1.5000600@pobox.com> <20050922061849.GJ7929@suse.de> <20050922061849.GJ7929@suse.de> <4332ABDC.3030106@rtr.ca>
Date: Thu, 22 Sep 2005 14:08:30 +0100
Message-Id: <E1EIQoQ-0007FT-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord <liml@rtr.ca> wrote:

> Rather than sitting around for another six months hoping the problem
> will go away (it won't), perhaps we should just update/merge Jen's
> patch as a sorely needed interim fix.

As a datapoint, we've been shipping it in Ubuntu for a month or so now
and we haven't had any reported problems.
-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
