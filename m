Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbUFMVnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbUFMVnE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 17:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbUFMVnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 17:43:04 -0400
Received: from a62-216-22-210.adsl.cistron.nl ([62.216.22.210]:57608 "EHLO
	mail.kwaak.net") by vger.kernel.org with ESMTP id S261184AbUFMVnD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 17:43:03 -0400
Date: Sun, 13 Jun 2004 23:42:09 +0200
From: Ard van Breemen <ard@kwaak.net>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atiixp ac97 timeout gives error (2.6.7-rc2)
Message-ID: <20040613214209.GA1274@kwaak.net>
References: <20040608111621.GW18505@kwaak.net> <s5hk6yi2os4.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hk6yi2os4.wl@alsa2.suse.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2004 at 02:54:35PM +0200, Takashi Iwai wrote:
> At Tue, 8 Jun 2004 13:16:22 +0200,
> Ard van Breemen wrote:
> > I've patched the atiixp driver by ignoring the error when the
> 
> It's already fixed in the mm tree.  Please give a try.

Yes, it works. Thanks. Now I also understand what happens :-).
