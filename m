Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262265AbTIHNZh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 09:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262280AbTIHNYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 09:24:24 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:51677 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262304AbTIHNYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 09:24:04 -0400
Date: Thu, 4 Sep 2003 19:17:58 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Some read-errors on floppys not reported on 2.4.22
Message-ID: <20030904171758.GR1358@openzaurus.ucw.cz>
References: <Pine.LNX.4.53.0308291207430.25423@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0308291207430.25423@chaos>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Success, even where there are lots of CRC errors that
> prematurely terminate the read:

Can you find out if it works in 2.4.21?
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

