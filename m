Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbTFZOt3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 10:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261846AbTFZOt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 10:49:28 -0400
Received: from pcp701542pcs.bowie01.md.comcast.net ([68.50.82.18]:59995 "EHLO
	lucifer.gotontheinter.net") by vger.kernel.org with ESMTP
	id S261843AbTFZOt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 10:49:26 -0400
Subject: Re: Is their an explanation of various kernel
	versions/brances/patches/? (-mm, -ck, ..)
From: Disconnect <lkml@sigkill.net>
To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200306251857.48341.brian@brianandsara.net>
References: <bdd64m$3dr$1@main.gmane.org>
	 <200306251857.48341.brian@brianandsara.net>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1056639815.1056.65.camel@slappy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 26 Jun 2003 11:03:35 -0400
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-25 at 19:57, Brian Jackson wrote:
> I don't know of a website that tracks that stuff, but here goes my knowledge 
> of the different patchsets:
> 
> for the most part all of them are testing grounds for patches that someday 
> hope to be in the vanilla kernel
> 
> mm - Andrew Morton - vm related testing ground for dev tree
> ck - Con Kolivas - desktop/interactivity patches
> kj - Kernel Janitors - testing ground for kernel cleanups on development trees
> mjb - Martin J Bligh - scalability stuff
> wli - William Lee Irwin - other vm related stuff for dev tree that Andrew
> 	Morton may not have time for
> ac - Alan Cox - lately it's been a testing ground for new ide
> lsm - Chris Wright - Linux Security Modules, provides a lightweight, general
> 	purpose framework for access control
> osdl - Stephen Hemminger, ? maybe enterprise stuff
> laptop - Hanno Böck - unproven laptop type patches
> aa - Andrea Arcangeli - stable series vm stuff
> dj - Dave Jones - cleanups/AGP
> rmap - Rik van Riel - reverse mapping vm for 2.4
> pgcl - William Lee Irwin - ?

To add a couple:
 dis - Laptop-related (ACPI, swsusp, cpufreq, etc) patches
 jp - Security/performance?

-- 
Disconnect <lkml@sigkill.net>

