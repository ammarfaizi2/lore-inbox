Return-Path: <linux-kernel-owner+w=401wt.eu-S1763023AbWLKTHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763023AbWLKTHF (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 14:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763018AbWLKTHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 14:07:04 -0500
Received: from torres.zugschlus.de ([85.10.211.154]:47381 "EHLO
	torres.zugschlus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937573AbWLKTHC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 14:07:02 -0500
Date: Mon, 11 Dec 2006 20:07:01 +0100
From: Marc Haber <mh+linux-kernel@zugschlus.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 file content corruption on ext3
Message-ID: <20061211190700.GA15165@torres.l21.ma.zugschlus.de>
References: <20061207155740.GC1434@torres.l21.ma.zugschlus.de> <4578465D.7030104@cfl.rr.com> <1165541892.1063.0.camel@sebastian.intellilink.co.jp> <20061208164206.GA1125@torres.l21.ma.zugschlus.de> <20061209104758.GA10261@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061209104758.GA10261@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, 2006 at 11:47:58AM +0100, Jan Kara wrote:
>   In the mean time
>   does mounting the filesystem with data=writeback help?

I have now nine hours uptime with data=writeback, and the file is
still OK. Looks good.

By this posting, I'm going to invoke murphy, so I'll report again
tomorrow.

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Mannheim, Germany  |  lose things."    Winona Ryder | Fon: *49 621 72739834
Nordisch by Nature |  How to make an American Quilt | Fax: *49 621 72739835
