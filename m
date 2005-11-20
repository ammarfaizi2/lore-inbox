Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbVKTS6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbVKTS6i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 13:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbVKTS6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 13:58:38 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:315 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S1750727AbVKTS6h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 13:58:37 -0500
Date: Sun, 20 Nov 2005 20:00:08 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] prefer pkg-config for the QT check
Message-ID: <20051120190008.GA9793@mars.ravnborg.org>
References: <Pine.LNX.4.61.0511170147200.861@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0511170147200.861@scrub.home>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2005 at 02:17:28AM +0100, Roman Zippel wrote:
> Hi,
> 
> This makes pkg-config now the prefered way to configure QT and properly 
> fixes the recent Fedora breakage and leaves the old QT detection as 
> fallback mechanism.
> 
> Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
Tested with and without pgk-config on gentoo. No problems.
This is 2.6.15-rc2 material IMO.

Acked-by: Sam Ravnborg <sam@ravnborg.org>


	Sam

