Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262195AbUJZJ0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbUJZJ0s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 05:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbUJZJ0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 05:26:48 -0400
Received: from sd291.sivit.org ([194.146.225.122]:18307 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262195AbUJZJ0q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 05:26:46 -0400
Date: Tue, 26 Oct 2004 11:28:02 +0200
From: Stelian Pop <stelian@popies.net>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 0/5] Sonypi driver model & PM changes
Message-ID: <20041026092802.GC2998@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	LKML <linux-kernel@vger.kernel.org>, Vojtech Pavlik <vojtech@suse.cz>
References: <20041025152029.4788.qmail@web81303.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041025152029.4788.qmail@web81303.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 08:20:29AM -0700, Dmitry Torokhov wrote:

> I'd say just allocate brand new events for all combinations and do not
> worry that the default X keyboard drivers to not get them. There are
> already patches in Gentoo adding both keyboard and mouse event support
> to X [1] and it is only matter of time ofr other duistributions to pick
> it up as well.
> 
> I think it is sensible for an supplemental driver (sonypi) to require
> some additional support form userspace and not to force itself into
> boundaries of a legacy protocol.
> 
> -- 
> Dmitry
> 
> [1] 
> http://csociety-ftp.ecn.purdue.edu/pub/gentoo/distfiles/xorg-x11-6.8.0-patches-0.2.5.tar.bz2
> Extract patches 9000, 9001 and 9002. Btw, these are not mine - I have
> Not even tries them myself but I have read several success stories.

Got them and trying to build the new drivers right now. Thanks !

Stelian.
-- 
Stelian Pop <stelian@popies.net>    
