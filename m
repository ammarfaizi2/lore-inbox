Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261640AbVCGG40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbVCGG40 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 01:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbVCGG40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 01:56:26 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:10731 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261640AbVCGG4W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 01:56:22 -0500
Date: Mon, 7 Mar 2005 07:57:07 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Micheal Marineau <marineam@engr.orst.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Treat ALPS mouse buttons as mouse buttons
Message-ID: <20050307065707.GA1778@ucw.cz>
References: <422BA727.1030506@engr.orst.edu> <20050307055019.GA1541@ucw.cz> <422BF0B0.3030109@engr.orst.edu> <20050307062611.GA1684@ucw.cz> <422BF62E.9080707@engr.orst.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422BF62E.9080707@engr.orst.edu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 06, 2005 at 10:35:26PM -0800, Micheal Marineau wrote:

> > Thanks. Could you also attach the one from -mm1? It's a bit different.
> > 
> here is the mm1 version:
> I: Bus=0011 Vendor=0001 Product=0001 Version=ab41
> N: Name="AT Translated Set 2 keyboard"
> P: Phys=isa0060/serio0/input0
> H: Handlers=kbd mouse0
> B: EV=120017
> B: KEY=40000 4 2000000 3802078 f840d001 b2ffffdf ffefffff ffffffff fffffffe
> B: REL=140
> B: MSC=10
> B: LED=7
> 
> I: Bus=0011 Vendor=0002 Product=0008 Version=0000
> N: Name="PS/2 Mouse"
> P: Phys=isa0060/serio1/input1
> H: Handlers=mouse1
> B: EV=7
> B: KEY=70000 0 0 0 0 0 0 0 0
> B: REL=3
> 
> I: Bus=0011 Vendor=0002 Product=0008 Version=6337
> N: Name="AlpsPS/2 ALPS GlidePoint"
> P: Phys=isa0060/serio1/input0
> H: Handlers=mouse2
> B: EV=f
> B: KEY=420 0 70000 0 0 0 0 0 0 0 0
> B: REL=3
> B: ABS=1000003

Thanks!

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
