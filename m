Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262017AbVAJAHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbVAJAHV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 19:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbVAJAHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 19:07:21 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:4553 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262011AbVAJAHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 19:07:05 -0500
Subject: Re: starting with 2.7
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Richard Moser <nigelenki@comcast.net>
Cc: znmeb@cesmail.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41E0A032.5050106@comcast.net>
References: <1697129508.20050102210332@dns.toxicfilms.tv>
	 <41DD9968.7070004@comcast.net>
	 <1105045853.17176.273.camel@localhost.localdomain>
	 <1105115671.12371.38.camel@DreamGate>  <41DEC5F1.9070205@comcast.net>
	 <1105237910.11255.92.camel@DreamGate>  <41E0A032.5050106@comcast.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105278618.12054.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 09 Jan 2005 23:02:23 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm claiming that an IT infrastructure that has to support 2.6 as-is
> will be wildly more complex and more expensive than one supporting a
> truly stable one with the same efficiency.  It keeps changing.  New
> features must be added that aren't amply tested (and due to the 2.6
> development structure, ample testing before mainline integration is much
> more difficult).

Large IT businesses already deployed 2.6 (SuSE) and will do so more soon
(Red Hat). These vendors are guaranteeing long term stable maintenance
of those versions.

> Ask Linus to start making 3rd party binary module support a reality then.

Binary module support is pretty irrelevant. Good management of out of
tree source code recompiling is a much more useful and relevant topic. 
2.6 has caused an inadvertent problem there because with 2.4 it was
*much* easier to grab 2.4.x and drop in a 2.4.y version of a driver.

