Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261827AbVFKU0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbVFKU0p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 16:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbVFKU0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 16:26:45 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:52192 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261825AbVFKUZg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 16:25:36 -0400
Date: Sat, 11 Jun 2005 22:25:30 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Sam Ravnborg <sam@ravnborg.org>
cc: "Ilan S." <ilan_sk@netvision.net.il>, linux-kernel@vger.kernel.org
Subject: Re: 'hello world' module
In-Reply-To: <20050611181753.GA17310@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.61.0506112225040.2372@yvahk01.tjqt.qr>
References: <200506111511.02581.ilan_sk@netvision.net.il>
 <20050611181753.GA17310@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> [ilanso@Netvision Kernel]$ make -C /home/ilanso/src/linux-2.6.11.11 M=`pwd`

Try adding "modules" at the end?

