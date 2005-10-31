Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932443AbVJaN1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbVJaN1K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 08:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbVJaN1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 08:27:10 -0500
Received: from postel.suug.ch ([195.134.158.23]:42971 "EHLO postel.suug.ch")
	by vger.kernel.org with ESMTP id S1751132AbVJaN1J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 08:27:09 -0500
Date: Mon, 31 Oct 2005 14:27:30 +0100
From: Thomas Graf <tgraf@suug.ch>
To: Adrian Bunk <bunk@stusta.de>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
Subject: Re: [2.6 patch] fix the "QoS and/or fair queueing" menu
Message-ID: <20051031132729.GK23537@postel.suug.ch>
References: <Pine.LNX.4.61.0510280902470.6910@yvahk01.tjqt.qr> <20051031102621.GF8009@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051031102621.GF8009@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Adrian Bunk <bunk@stusta.de> 2005-10-31 11:26
> This patch adjust some dependencies in net/sched/Kconfig for getting all 
> options that belong there under "QoS and/or fair queueing".
> 
> There is no actual semantic change in any dependency, the additional 
> dependencies are added for helping kconfig to figure out what belongs to 
> that menu.

Please hold on, I'm reworking the classification menu.
