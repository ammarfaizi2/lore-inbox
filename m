Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261749AbTIYHUB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 03:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbTIYHSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 03:18:35 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:52647 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261743AbTIYHS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 03:18:26 -0400
Date: Thu, 25 Sep 2003 09:04:48 +0200
From: Pavel Machek <pavel@suse.cz>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, Robert Walsh <rjwalsh@durables.org>,
       wangdi <wangdi@clusterfs.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] kgdb-over-ethernet using netpoll api
Message-ID: <20030925070448.GD11901@openzaurus.ucw.cz>
References: <20030922184738.GM2414@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030922184738.GM2414@waste.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch refactors kgdb-over-ethernet to use the netpoll API and

Whats the status of kgdb-over-ethernet for 2.4, btw?
I tried googling for it but found nothing.
				Pavel
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

