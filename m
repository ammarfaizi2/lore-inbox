Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266435AbUG0Pda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266435AbUG0Pda (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 11:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266425AbUG0PdC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 11:33:02 -0400
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:41183 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S266409AbUG0Pcx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 11:32:53 -0400
Date: Tue, 27 Jul 2004 11:32:50 -0400
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       lkml List <linux-kernel@vger.kernel.org>
Subject: Re: Preliminary Linux Key Infrastructure 0.01-alpha1
Message-ID: <20040727153250.GD31236@fieldses.org>
References: <E1Bow3S-0001qO-00@calista.eckenfels.6bone.ka-ip.net> <FC5D956C-DEBD-11D8-9EC8-000393ACC76E@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FC5D956C-DEBD-11D8-9EC8-000393ACC76E@mac.com>
User-Agent: Mutt/1.5.6+20040523i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2004 at 12:40:57AM -0400, Kyle Moffett wrote:
> On Jul 25, 2004, at 23:21, Bernd Eckenfels wrote:
> >In article <65EFF013-DEAA-11D8-9612-000393ACC76E@mac.com> you wrote:
> >>Preliminary Linux Key Infrastructure 0.01-alpha1:
> >
> >What kind of keys you want to store and what are they used for?
> 
> My code is in followup to the LKML discussion here:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=108700802812286&w=2
> 
> The goal is simply to put encryption keys in the kernel so they can be
> used by a variety of systems, AFS, NFSv4, dm-crypt, CryptoAPI, etc.
> 
> There was also a bit of a discussion on OpenAFS-devel about it too.

How does this compare with the patches posted by Erik Jacobson and by David
Howells?

--Bruce Fields
