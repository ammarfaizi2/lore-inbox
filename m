Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbVAaTBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbVAaTBU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 14:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVAaTBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 14:01:19 -0500
Received: from [66.35.79.110] ([66.35.79.110]:33159 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S261312AbVAaTBR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 14:01:17 -0500
Date: Mon, 31 Jan 2005 11:01:10 -0800
From: Tim Hockin <thockin@hockin.org>
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: Emmanuel Fleury <fleury@cs.aau.dk>, linux-kernel@vger.kernel.org
Subject: Re: [Watchdog] alim7101_wdt problem on 2.6.10
Message-ID: <20050131190110.GA21886@hockin.org>
References: <41FDDCA3.7090701@cs.aau.dk> <20050131072708.GA17354@hockin.org> <41FE7F3F.5020809@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41FE7F3F.5020809@sun.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2005 at 01:55:59PM -0500, Mike Waychison wrote:
> FWIW, some of the old cobalt boxes had the old south bridge revision
> with a WDT.  It managed to do resets/wdt off gpio pin 5 though, and
> there is a patch in Alan's 2.6.10-ac tree that handles it.

The old Cobalts also had a PIC attached to act as a WDT.  :)
