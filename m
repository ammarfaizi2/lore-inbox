Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbVIQXxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbVIQXxt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 19:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbVIQXxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 19:53:49 -0400
Received: from [194.216.112.127] ([194.216.112.127]:32903 "EHLO trollied.org")
	by vger.kernel.org with ESMTP id S1751236AbVIQXxt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 19:53:49 -0400
Date: Sun, 18 Sep 2005 00:53:35 +0100
From: John Levon <levon@movementarian.org>
To: Soeren Sandmann <sandmann@daimi.au.dk>,
       bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org
Subject: Re: Announce:  Sysprof 1.0 -- a sampling, systemwide Linux profiler
Message-ID: <20050917235335.GA29382@trollied.org>
References: <ye8br2r9zi7.fsf@horse06.daimi.au.dk> <20050917211656.GA27448@outpost.ds9a.nl> <ye8slw38i5g.fsf@horse06.daimi.au.dk> <20050917222015.GA32019@trollied.org> <20050917232810.GB3881@irc.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050917232810.GB3881@irc.pl>
X-Url: http://www.movementarian.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 18, 2005 at 01:28:10AM +0200, Tomasz Torcz wrote:

> > Building a GUI around OProfile would have been welcome, but you've
> > chosen to re-implement the entire stack...
> 
>  Sysprof seems to profile userspace simultanous, while oprofile is
> bounded to kernel calls.

I don't know how you got this idea, but it's completely wrong.

john
