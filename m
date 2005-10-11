Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbVJKCXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbVJKCXU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 22:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbVJKCXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 22:23:20 -0400
Received: from mtl.rackplans.net ([65.39.167.249]:493 "HELO innerfire.net")
	by vger.kernel.org with SMTP id S1751351AbVJKCXU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 22:23:20 -0400
Date: Mon, 10 Oct 2005 22:23:19 -0400 (EDT)
From: Gerhard Mack <gmack@innerfire.net>
To: Dave Airlie <airlied@gmail.com>
cc: Lars Roland <lroland@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Direct Rendering drivers for ATI X300 ?
In-Reply-To: <21d7e9970510101726h5bf920f0y3b7c42a6ff98734e@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0510102222470.26127@innerfire.net>
References: <Pine.LNX.4.64.0510101230360.8804@innerfire.net> 
 <4ad99e050510101200m6f3e1abh7ff8fb6b08b3c0e6@mail.gmail.com>
 <21d7e9970510101726h5bf920f0y3b7c42a6ff98734e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there an entry for this card?

0000:05:00.0 VGA compatible controller: ATI Technologies Inc RV370 5B60
[Radeon X300 (PCIE)]
0000:05:00.1 Display controller: ATI Technologies Inc RV370 [Radeon
X300SE]

0000:05:00.0 0300: 1002:5b60
0000:05:00.1 0380: 1002:5b70

	Gerhard


On Tue, 11 Oct 2005, Dave Airlie wrote
> Date: Tue, 11 Oct 2005 10:26:41 +1000
> From: Dave Airlie <airlied@gmail.com>
> To: Lars Roland <lroland@gmail.com>
> Cc: Gerhard Mack <gmack@innerfire.net>, linux-kernel@vger.kernel.org
> Subject: Re: Direct Rendering drivers for ATI X300 ?
> 
> >
> > What are your dmesg reporting, when loading the modules, if you see
> > something along these lines:
> >
> 
> For PCI Express Radeon cards:
> 
> The kernel portions are in my -git tree ready for pushing to Linus
> after the next release is made,
> 
> The userspace portions requires X.org/Mesa/DRM CVS trees.
> 
> The DRM CVS also contains the kernel portions....
> 
> Dave.
> 

--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.
