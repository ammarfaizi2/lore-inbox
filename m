Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbWATMEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbWATMEv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 07:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbWATMEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 07:04:51 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:32520 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750873AbWATMEv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 07:04:51 -0500
Date: Fri, 20 Jan 2006 13:06:28 +0100
From: Jens Axboe <axboe@suse.de>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Phillip Susi <psusi@cfl.rr.com>, Neil Brown <neilb@suse.de>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       "Lincoln Dale (ltd)" <ltd@cisco.com>, Michael Tokarev <mjt@tls.msk.ru>,
       linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [PATCH 000 of 5] md: Introduction
Message-ID: <20060120120627.GF13429@suse.de>
References: <26A66BC731DAB741837AF6B2E29C1017D47EA0@xmb-hkg-413.apac.cisco.com> <Pine.LNX.4.61.0601181427090.19392@yvahk01.tjqt.qr> <17358.52476.290687.858954@cse.unsw.edu.au> <43D00FFA.1040401@cfl.rr.com> <17360.5011.975665.371008@cse.unsw.edu.au> <43D02033.4070008@cfl.rr.com> <17360.9233.215291.380922@cse.unsw.edu.au> <43D04828.8010107@cfl.rr.com> <20060120105306.GY22163@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060120105306.GY22163@marowsky-bree.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20 2006, Lars Marowsky-Bree wrote:
> Oversimplifying to "dm is better than md" is just stupid.

Indeed. But "generally" md is faster and more efficient in the way it
handles ios, it doesn't do any splitting unless it has to.

-- 
Jens Axboe

