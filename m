Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267464AbUHXLMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267464AbUHXLMj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 07:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267482AbUHXLMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 07:12:39 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:61920 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S267464AbUHXLMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 07:12:34 -0400
Date: Tue, 24 Aug 2004 13:00:24 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alexander Rauth <Alexander.Rauth@promotion-ie.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: radeonfb problems (console blanking & acpi suspend)
Message-ID: <20040824110024.GA3502@openzaurus.ucw.cz>
References: <1093277876.9973.15.camel@pro30.local.promotion-ie.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093277876.9973.15.camel@pro30.local.promotion-ie.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 2) after an acpi suspend the backlight goes back on but there is no data
> displayed on the screen (no X running nor started since boot)
> 
> If more information is needed for diagnosis then please email me.

Known problem for suspend-to-ram, see Ole Rohne's patches.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

