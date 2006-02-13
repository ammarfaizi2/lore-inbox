Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030192AbWBMWBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030192AbWBMWBy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 17:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbWBMWBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 17:01:54 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:63203 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964871AbWBMWBx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 17:01:53 -0500
Date: Mon, 13 Feb 2006 23:01:47 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>
cc: mingo@elte.hu, tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] hrtimer: remove useless const
In-Reply-To: <20060213123547.41af78c4.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0602132259360.30994@scrub.home>
References: <Pine.LNX.4.61.0602130209340.23804@scrub.home>
 <1139830116.2480.464.camel@localhost.localdomain> <Pine.LNX.4.61.0602131235180.30994@scrub.home>
 <20060213114612.GA30500@elte.hu> <Pine.LNX.4.61.0602131649560.30994@scrub.home>
 <20060213123547.41af78c4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 13 Feb 2006, Andrew Morton wrote:

> There's been enough churn here that it'll be counterproductive for me to
> continue to munge on your patches.  I'll drop the lot and will await rev
> #2.

It's coming shortly, but please give it at least a test run...

> I don't think any of this was critical for 2.6.16.

Well, IMO it's as critical as the complete hrtimer patch.

bye, Roman
