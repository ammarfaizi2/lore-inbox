Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261587AbVEAKzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbVEAKzU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 06:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVEAKzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 06:55:20 -0400
Received: from ns1.suse.de ([195.135.220.2]:29882 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261587AbVEAKzN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 06:55:13 -0400
Message-ID: <4274B587.7070909@suse.de>
Date: Sun, 01 May 2005 12:55:03 +0200
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041207 Thunderbird/1.0 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lgb@lgb.hu
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Compaq Armada E500 notebook and 2.6.x kernels
References: <20050501084951.GA19102@vega.lgb.hu>
In-Reply-To: <20050501084951.GA19102@vega.lgb.hu>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gábor Lénárt wrote:
> Hello,
> 
> Sorry, maybe it's an OT here but I'm out of ideas (including google). My
> problem is our Compaq Armada E500. It worked quite well with 2.4.x kernels.
> However with 2.6.x kernels it always freezes. No log or opps, and the exact

> from various sources with no solution ... It renders this notebook unusable
> for us, since distribution(s) we wanted to use already changed from 2.4.x
> kernels to 2.6. Is there ANY ideas? On request I can send various
> information on this notebook, but at the moment I can't. Thanx in advance.

I have two E500's at hand, one is mission critical (my wife's :-) and
both run fine since 2.6.0test-days. The only minor problems i had were
the touchpad misdetected in early 2.6 (long since fixed) and one time,
when i had something that smelled awfully like memory corruption after
ACPI suspend to RAM, but that one never happened again.

Note that E500 apparently come in many different "flavors", i have one
P3-800 and one P3-650 and they need e.g. different module parameters to
get speedstep going.

My experience is almost exclusively with suse-patched kernels, but i do
not remember putting any band-aids for the E500 into those.

Are you running with APM or ACPI? Mine are running with ACPI since at
least 18 month with everything (suspend etc) working out of the box.
-- 
Stefan Seyfried, QA / R&D Team Mobile Devices, SUSE LINUX Nürnberg.

"Any ideas, John?"
"Well, surrounding them's out."
