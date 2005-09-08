Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964807AbVIHRTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbVIHRTf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 13:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbVIHRTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 13:19:35 -0400
Received: from S01060013104bd78e.vc.shawcable.net ([24.85.145.160]:30106 "EHLO
	r3000.fsmlabs.com") by vger.kernel.org with ESMTP id S964807AbVIHRTe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 13:19:34 -0400
Date: Thu, 8 Sep 2005 10:18:56 -0700 (PDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Martin Vlk <MVlk@curamsoftware.com>
cc: linux-kernel@vger.kernel.org, Jens Pittler <jpitt@physik.uni-leipzig.de>
Subject: Re: The BogoMIPS value sometimes too low on Intel Mobile P3
In-Reply-To: <949F43A185737046A32445D37D15EC0201BE7645@Mail04.curamsoftware.com>
Message-ID: <Pine.LNX.4.63.0509081018031.8052@r3000.fsmlabs.com>
References: <949F43A185737046A32445D37D15EC0201BE7645@Mail04.curamsoftware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Martin,

On Thu, 8 Sep 2005, Martin Vlk wrote:

> I am running a custom-built kernel 2.6.10 on an Intel Mobile P3 processor. (Acer
> TravelMate 620)

Please try it with a more recent kernel, there have been some patches 
which take into consideration SMIs occuring during the calibration loop.

Thanks,
	Zwane

