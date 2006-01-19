Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751389AbWASRvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbWASRvR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 12:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbWASRvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 12:51:17 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:36302 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751389AbWASRvQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 12:51:16 -0500
Date: Thu, 19 Jan 2006 18:51:14 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: maximilian attems <maks@sternwelten.at>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Sam Ravnborg <sam@ravnborg.org>, Bastian Blank <waldi@debian.org>
Subject: Re: [patch] kbuild: add automatic updateconfig target
In-Reply-To: <20060119173728.GA4866@nancy>
Message-ID: <Pine.LNX.4.61.0601191849121.30994@scrub.home>
References: <20060118194056.GA26532@nancy> <Pine.LNX.4.61.0601191248070.11765@scrub.home>
 <20060119173728.GA4866@nancy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 19 Jan 2006, maximilian attems wrote:

> > What's wrong with 'yes "" | make oldconfig'?
> > If we added such a make target, it would be basically just this.
> 
> why should we add this workaround, when adding a target
> that sets the default is so easy?

What advantages would this have compared to the "workaround"?

bye, Roman
