Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265383AbTIJRrg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 13:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265386AbTIJRrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 13:47:35 -0400
Received: from mta07-svc.ntlworld.com ([62.253.162.47]:16862 "EHLO
	mta07-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S265383AbTIJRre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 13:47:34 -0400
Subject: Re: Audio skipping with alsa
From: Russ Garrett <rg@tcslon.com>
To: root@chaos.analogic.com
Cc: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53.0309101037120.12986@chaos>
References: <1063116861.852.50.camel@russell> <s5hk78gvkt7.wl@alsa2.suse.de>
	 <Pine.LNX.4.53.0309101536080.1411@pnote.perex-int.cz>
	 <s5hhe3kvjtc.wl@alsa2.suse.de>  <Pine.LNX.4.53.0309101037120.12986@chaos>
Content-Type: text/plain
Message-Id: <1063216041.1208.10.camel@russell>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 10 Sep 2003 18:47:21 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't see the driver in linux-2.4.22/drivers/sound, so I can't
> look at it directly, 

It's ALSA, so it isn't in the 2.4 tree - it's in sound/pci/ice1712/ in
2.6. And FWIW, this happens continuously, not just in the 25 seconds (or
whatever) after playback starts.

-- 
Russ Garrett		http://russ.garrett.co.uk
russ@garrett.co.uk

