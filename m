Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263502AbUCVVao (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 16:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263642AbUCVVao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 16:30:44 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.18]:42805 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S263502AbUCVVai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 16:30:38 -0500
From: Jos Hulzink <josh@stack.nl>
To: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: OSS: cleanup or throw away
Date: Mon, 22 Mar 2004 22:32:20 +0100
User-Agent: KMail/1.6.1
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200403221955.52767.jos@hulzink.net> <20040322202220.GA13042@mulix.org>
In-Reply-To: <20040322202220.GA13042@mulix.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403222232.20994.josh@stack.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 March 2004 21:22, Muli Ben-Yehuda wrote:
> In my not so humble opinion, throwing OSS away will be a big mistake,
> as long as there are people willing to maintain it. Keep it there and
> let the users (or distributions) choose what to use. I've seen
> multiple bug reports of cards that work with OSS and don't work with
> ALSA (and vice versa), so keeping both seems the proper thing to
> do. Personally, I maintain one OSS driver, and fix bugs in others
> occasionally.

Looking at the amount of warnings in the OSS drivers (depricated 
check_region), the OSS drivers seem -with all respect for your hard work- not 
so well maintained anymore. I'm willing to fix them all, but not if entire 
OSS is ditched away Real Soon Now (tm).

Best regards,

Jos Hulzink
