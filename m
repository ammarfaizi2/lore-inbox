Return-Path: <linux-kernel-owner+w=401wt.eu-S1161107AbXAEO0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161107AbXAEO0S (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 09:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161112AbXAEO0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 09:26:18 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:38210 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161107AbXAEO0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 09:26:16 -0500
Date: Fri, 5 Jan 2007 15:25:11 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] All Transmeta CPUs have constant TSCs
In-Reply-To: <200701050148.l051mHGM005275@terminus.zytor.com>
Message-ID: <Pine.LNX.4.61.0701051524440.7813@yvahk01.tjqt.qr>
References: <200701050148.l051mHGM005275@terminus.zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 4 2007 17:48, H. Peter Anvin wrote:
>
>[i386] All Transmeta CPUs have constant TSCs
>All Transmeta CPUs ever produced have constant-rate TSCs.

A TSC is ticking according to the CPU frequency, is not it?


	-`J'
-- 
