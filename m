Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWIGNZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWIGNZQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 09:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWIGNZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 09:25:16 -0400
Received: from yzordderrex.netnoteinc.com ([212.17.35.167]:47053 "EHLO
	yzordderrex.lincor.com") by vger.kernel.org with ESMTP
	id S932096AbWIGNZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 09:25:14 -0400
Message-ID: <45001D90.3010601@draigBrady.com>
Date: Thu, 07 Sep 2006 14:24:32 +0100
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Samuel Tardieu <sam@rfc1149.net>
CC: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: add support for w83697hg chip
References: <87fyf5jnkj.fsf@willow.rfc1149.net> <44FEAD7E.6010201@draigBrady.com> <2006-09-06-13-29-46+trackit+sam@rfc1149.net> <44FEB5B6.10008@draigBrady.com> <2006-09-06-14-07-50+trackit+sam@rfc1149.net> <20060906194149.GA2386@infomag.infomag.iguana.be> <2006-09-07-11-57-00+trackit+sam@rfc1149.net>
In-Reply-To: <2006-09-07-11-57-00+trackit+sam@rfc1149.net>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Tardieu wrote:
> Ah, we did duplicate work then, too bad I didn't notice it first :)

[snip valid points]

> I suggest that you use the following patch instead. It is my patch
> renamed as w83697hf_wdt (it covers hf and hg variants) with the
> following three modifications: I added Marcus Junker copyright with mine,
> as he beats me by a few days, I disable the watchdog until it is
> first used, and I set the default address to 0x2e to make it compatible
> with Marcus' original patch.

I concur.

Pádraig.

p.s. Wim, mail to your address is bouncing
