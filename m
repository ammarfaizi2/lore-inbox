Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965036AbWIEPSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965036AbWIEPSg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 11:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965108AbWIEPSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 11:18:36 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:56249 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S965036AbWIEPSe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 11:18:34 -0400
X-ORBL: [67.117.73.34]
Date: Tue, 5 Sep 2006 18:18:09 +0300
To: lamikr <lamikr@cc.jyu.fi>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] Add gsm phone support for the mixer in tsc2101 alsa driver.
Message-ID: <20060905151808.GC18073@atomide.com>
References: <44E51565.6020505@cc.jyu.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E51565.6020505@cc.jyu.fi>
User-Agent: Mutt/1.5.11
From: tony@atomide.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* lamikr <lamikr@cc.jyu.fi> [060818 04:19]:
> Add gsm phone support for the mixer in tsc2101 alsa driver. This allows
> selecting cellphone for the playback target via alsa mixer interface.
> Selection will connect gsm module to speaker and microphone allowing the
> user to speak to phone and listen the opponents voice. Tested in ipaq
> h63xx by using gomunicator as an application. Tux wanna call home, and
> now Tux can finally call home :-)

Cool that you got the phone features working :)

Tony
