Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbUJTOna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUJTOna (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 10:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266183AbUJTOm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 10:42:58 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:10135 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266683AbUJTOhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 10:37:50 -0400
Date: Mon, 18 Oct 2004 13:41:09 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Yu, Luming" <luming.yu@intel.com>
Cc: M <mru@mru.ath.cx>, linux-kernel@vger.kernel.org
Subject: Re: High pitched noise from laptop: processor.c in linux 2.6
Message-ID: <20041018114109.GC4400@openzaurus.ucw.cz>
References: <3ACA40606221794F80A5670F0AF15F8405D3BF5B@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8405D3BF5B@pdsmsx403>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> ... and lose all the benefits of HZ=1000.  What would happen if one
> >> were to set HZ to a higher value, like 10000?
> 
> There is a similar issue filed on :
> http://bugzilla.kernel.org/show_bug.cgi?id=3406
> 

He he, someone should write a driver to play music on
those capacitors....
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

