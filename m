Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268190AbUHXSwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268190AbUHXSwK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 14:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268206AbUHXSwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 14:52:09 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:50363 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S268190AbUHXSwH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 14:52:07 -0400
Date: Tue, 24 Aug 2004 20:52:05 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Jesper Juhl <juhl-lkml@dif.dk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Shouldn't kconfig defaults match recommendations in help text?
In-Reply-To: <Pine.LNX.4.61.0408232050450.3767@dragon.hygekrogen.localhost>
Message-ID: <Pine.LNX.4.61.0408242042150.12756@scrub.home>
References: <Pine.LNX.4.61.0408232050450.3767@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 23 Aug 2004, Jesper Juhl wrote:

> Would patches to change default configuration choices to match the 
> recommendation given in the help text (if any) be acceptable? If not I'd 
> be interrested in the reasons why not.

Different configurations require different defaults and the current help 
text is rather static. The basic problem is that most recommendations are 
rather ix86 specific. I think an overuse of defaults is the wrong way to 
go.

bye, Roman
