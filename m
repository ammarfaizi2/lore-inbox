Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261421AbUKSOGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbUKSOGE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 09:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbUKSOGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 09:06:03 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:27105 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261419AbUKSOFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 09:05:54 -0500
Date: Fri, 19 Nov 2004 15:05:52 +0100
From: Jan Kara <jack@suse.cz>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Allow disabling quota messages to console
Message-ID: <20041119140552.GA7518@atrey.karlin.mff.cuni.cz>
References: <20041119114558.GA11334@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.53.0411191303550.11131@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0411191303550.11131@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  Hello!
> >
> >  Attached patch allows disabling of quota messages about exceeding of
> >limits to console (some people don't like them disturbing their output).
> >The patch applies well to any recent kernel. Please apply.
> >
> You already posted this patch in the past, yet it's not in in 2.6.10-rc2.
  Yes, that's exactly why I'm resending it (which I forgot to mention,
sorry) because it probably got lost somewhere...

								Honza
> 
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
