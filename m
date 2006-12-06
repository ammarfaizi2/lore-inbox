Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936938AbWLFRoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936938AbWLFRoW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 12:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936942AbWLFRoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 12:44:22 -0500
Received: from cantor2.suse.de ([195.135.220.15]:43755 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936938AbWLFRoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 12:44:21 -0500
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: [PATCH] more sanity checks in Dwarf2 unwinder
Date: Wed, 6 Dec 2006 17:41:44 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <456D7985.76E4.0078.0@novell.com> <200611291414.56268.ak@suse.de> <457458C3.76E4.0078.0@novell.com>
In-Reply-To: <457458C3.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612061741.44244.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 December 2006 17:20, Jan Beulich wrote:
> >Would it be possible to add printks for the EIOs? We want to know 
> >when dwarf2 is corrupted.
> 
> Here's a patch to do this and some more (applies on firstfloor tree, but
> probably not on plain 2.6.19).


Added thanks

I added Documentation of the new option.

-Andi
