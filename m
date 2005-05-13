Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261931AbVEMLau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbVEMLau (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 07:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262252AbVEMLat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 07:30:49 -0400
Received: from cantor2.suse.de ([195.135.220.15]:33162 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262234AbVEMLa2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 07:30:28 -0400
Date: Fri, 13 May 2005 13:30:23 +0200
From: Andi Kleen <ak@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Alexander Nyberg <alexn@telia.com>, Jan Beulich <JBeulich@novell.com>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [discuss] Re: [PATCH] adjust x86-64 watchdog tick calculation
Message-ID: <20050513113023.GD15755@wotan.suse.de>
References: <s2832159.057@emea1-mh.id2.novell.com> <1115892008.918.7.camel@localhost.localdomain> <20050512142920.GA7079@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050512142920.GA7079@openzaurus.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Because it kills machine when interrupt latency gets too high?
> Like reading battery status using i2c...

That's a bug in the I2C reader then. Don't shot the messenger for bad news.


-Andi
