Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262177AbVBUXoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbVBUXoi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 18:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262178AbVBUXoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 18:44:38 -0500
Received: from mail1.skjellin.no ([80.239.42.67]:58498 "EHLO mx1.skjellin.no")
	by vger.kernel.org with ESMTP id S262177AbVBUXof (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 18:44:35 -0500
Message-ID: <421A725E.8010301@tomt.net>
Date: Tue, 22 Feb 2005 00:44:30 +0100
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: really bensoo_at_soo_dot_com <lnx-kern@soo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc4 seems broken for Nforce2 chipset
References: <20050221232806.GA27458@Sophia.soo.com>
In-Reply-To: <20050221232806.GA27458@Sophia.soo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

really bensoo_at_soo_dot_com wrote:
> Hi;
> 
> i'm crashing my box twice a day running 2.6.11-rc4
> when i turn on the Athlon-XP CPU bus disconnect.
> 
> When network activity is up over maybe 120KB/s and
> i'm playing a video file at the same time, then
> chances are good i'll lock up the box.
> 
> Box runs a Chaintech Summit 7NIF2 with 1G RAM and
> an Audigy 2  sound card.  When it locks up sometimes
> the sound card goes into a little loop where it
> replays approx the half second of audio leading
> up to the lockup.

Bus disconnect have never been reliable on my Athlon XP 1800+, 
regardless of operating system.
