Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbVIUPjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbVIUPjh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 11:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbVIUPjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 11:39:37 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:29870 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751092AbVIUPjg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 11:39:36 -0400
Date: Wed, 21 Sep 2005 17:39:23 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Herbert Poetzl <herbert@13thfloor.at>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] eliminate CLONE_* duplications
In-Reply-To: <20050921151124.GB10137@MAIL.13thfloor.at>
Message-ID: <Pine.LNX.4.61.0509211738160.3728@scrub.home>
References: <20050921092132.GA4710@MAIL.13thfloor.at>
 <Pine.LNX.4.61.0509211252160.3743@scrub.home> <20050921143954.GA10137@MAIL.13thfloor.at>
 <Pine.LNX.4.61.0509211648240.3743@scrub.home> <20050921151124.GB10137@MAIL.13thfloor.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 21 Sep 2005, Herbert Poetzl wrote:

> well, I thought that is what my patch did, so please
> could you elaborate on the 'properly' part, as this
> might be the missing information here ...

"It's more important to keep related definition together and organize them 
logically."

bye, Roman
