Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWG3JvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWG3JvN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 05:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbWG3JvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 05:51:13 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:31694 "EHLO smurf.noris.de")
	by vger.kernel.org with ESMTP id S932164AbWG3JvM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 05:51:12 -0400
Date: Sun, 30 Jul 2006 11:49:45 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: john stultz <johnstul@us.ibm.com>, ak@muc.de, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, bunk@stusta.de, lethal@linux-sh.org,
       hirofumi@mail.parknet.co.jp, asit.k.mallick@intel.com
Subject: Re: REGRESSION: the new i386 timer code fails to sync CPUs
Message-ID: <20060730094945.GW3662@kiste.smurf.noris.de>
References: <20060722173649.952f909f.akpm@osdl.org> <20060723081604.GD27566@kiste.smurf.noris.de> <20060723044637.3857d428.akpm@osdl.org> <20060723120829.GA7776@kiste.smurf.noris.de> <20060723053755.0aaf9ce0.akpm@osdl.org> <1153756738.9440.14.camel@localhost> <20060724171711.GA3662@kiste.smurf.noris.de> <20060724175150.GD50320@muc.de> <1153774443.12836.6.camel@localhost> <20060730020346.5d301bb5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060730020346.5d301bb5.akpm@osdl.org>
User-Agent: Mutt/1.5.11
From: Matthias Urlichs <smurf@smurf.noris.de>
X-Smurf-Spam-Score: -2.6 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Andrew Morton:
> I guess Matthias didn't test this patch.

Not yet, sorry -- the thing is my main server, and customers tend to
dislike downtime.

I've already got it scheduled for tonight.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
No matter where you go, there you are.
		-- Buckaroo Banzai
