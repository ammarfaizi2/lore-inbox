Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964974AbWEBUy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbWEBUy2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 16:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964947AbWEBUy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 16:54:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:56250 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964905AbWEBUy1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 16:54:27 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss]  Re: [RFC] make PC Speaker driver work on x86-64
Date: Tue, 2 May 2006 22:54:21 +0200
User-Agent: KMail/1.9.1
Cc: matthieu castet <castet.matthieu@free.fr>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
References: <200604291830.k3TIUA23009336@harpo.it.uu.se> <200605021950.17737.ak@suse.de> <4457C228.9050209@free.fr>
In-Reply-To: <4457C228.9050209@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605022254.22093.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 May 2006 22:33, matthieu castet wrote:

> > Also I have no idea if all x86 systems report the PC speaker in ACPI - a small
> > survey of that would be probably a good idea. I guess just most of them reporting it would be 
> > reasonable.
> That's why I keep the platform driver :
> the logic is try with ACPI in order to discover if there is a speaker. 
> If we failed, let's try the platform driver.

The patch doesn't apply to 2.6.17rc3-git2. For what tree did you do it?

Also can you please include a full changelog in the patch?

Thanks,
-Andi
