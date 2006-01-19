Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161413AbWASUU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161413AbWASUU5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 15:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161412AbWASUU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 15:20:57 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:53943 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1161375AbWASUU4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 15:20:56 -0500
Date: Thu, 19 Jan 2006 21:18:57 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Adrian Bunk <bunk@stusta.de>
cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       jgarzik@pobox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule SHAPER for removal
In-Reply-To: <20060119021150.GC19398@stusta.de>
Message-ID: <Pine.LNX.4.61.0601192118070.26558@yvahk01.tjqt.qr>
References: <20060119021150.GC19398@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Subject: [2.6 patch] schedule SHAPER for removal

Replaced by what; the QoS subsystem?


> config SHAPER
>-	tristate "Traffic Shaper (EXPERIMENTAL)"
>+	tristate "Traffic Shaper (OBSOLETE)"
> 	depends on EXPERIMENTAL


Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
