Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbVJaUkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbVJaUkY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 15:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbVJaUkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 15:40:24 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:40073 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751121AbVJaUkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 15:40:24 -0500
Date: Tue, 1 Jan 2002 06:46:03 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Deepak Saxena <dsaxena@plexity.net>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       tony@atomide.com
Subject: Re: [patch 2/5] Core HW RNG support
Message-ID: <20020101054603.GA632@openzaurus.ucw.cz>
References: <20051029191229.562454000@omelas> <20051029192433.428798000@omelas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051029192433.428798000@omelas>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


 ===================================================================
> --- /dev/null
> +++ linux-2.6-rng/drivers/char/rng/core.c

Perhaps drivers/random sounds better? At least you can pronounce it...

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

