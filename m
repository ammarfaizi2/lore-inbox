Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbWH1LHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbWH1LHG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 07:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964818AbWH1LHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 07:07:06 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:28089 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S964813AbWH1LHE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 07:07:04 -0400
Date: Mon, 28 Aug 2006 13:03:08 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Helge Hafting <helge.hafting@aitel.hist.no>
cc: David Woodhouse <dwmw2@infradead.org>, Rob Landley <rob@landley.net>,
       linux-kernel@vger.kernel.org, linux-tiny@selenic.com, devel@laptop.org
Subject: Re: [PATCH 0/4] Compile kernel with -fwhole-program --combine
In-Reply-To: <44F2CB09.2010809@aitel.hist.no>
Message-ID: <Pine.LNX.4.61.0608281302570.14305@yvahk01.tjqt.qr>
References: <1156429585.3012.58.camel@pmac.infradead.org> 
 <1156433068.3012.115.camel@pmac.infradead.org>  <200608251611.50616.rob@landley.net>
 <1156538115.3038.6.camel@pmac.infradead.org> <44F2CB09.2010809@aitel.hist.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 
> I suggest a new makefile target for this.
>
> I.e. "make bzImage" as always for those who do development and
> recompile after small changes/patches. 
> And a "make optImage" (optimized image) when building a
> kernel for production use, when you believe compiling every file
> and spending lots of extra time is worth it.

Good idea. :)


Jan Engelhardt
-- 
