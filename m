Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964880AbWFNFZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbWFNFZA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 01:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbWFNFZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 01:25:00 -0400
Received: from cantor2.suse.de ([195.135.220.15]:33474 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964880AbWFNFY7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 01:24:59 -0400
From: Andi Kleen <ak@suse.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: Athlon CPU detection/fixup is broken in 2.6.2-rc2
Date: Wed, 14 Jun 2006 07:24:55 +0200
User-Agent: KMail/1.9.3
Cc: tadavis@lbl.gov, linux-kernel@vger.kernel.org
References: <401ACA49.8070002@lbl.gov> <p73odwwqq7c.fsf@verdi.suse.de> <20060613221552.6ab46ac6.rdunlap@xenotime.net>
In-Reply-To: <20060613221552.6ab46ac6.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606140724.55081.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 June 2006 07:15, Randy.Dunlap wrote:
> On 14 Jun 2006 07:08:39 +0200 Andi Kleen wrote:
> 
> > Thomas Davis <tadavis@lbl.gov> writes:
> > 
> > > I looked in the Changelog - who changed it?
> > > 
> > > It doesn't work on my dual athlon 2200 MP system - kills it dead.
> > > 
> > > I can get 2.6.2-rc1 to boot.
> > 
> > Very vague report. Modern kernel like 2.6.16 doesn't work? And where
> > does it crash exactly and in what way?
> > 
> > If you got it down to that release with binary search can you identify the
> > exact changeset that caused the problem? 
> 
> Uhm, I admit that I ignored it given the kernel version and
> date:
> Date:	Fri, 30 Jan 2004 13:19:05 -0800

Hehe. I assumed he really did a binary search down to 2.6.2 ...
But didn't look at the date.

-Andi
