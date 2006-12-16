Return-Path: <linux-kernel-owner+w=401wt.eu-S1030765AbWLPI3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030765AbWLPI3R (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 03:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030768AbWLPI3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 03:29:16 -0500
Received: from torres.zugschlus.de ([85.10.211.154]:44483 "EHLO
	torres.zugschlus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030765AbWLPI3Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 03:29:16 -0500
Date: Sat, 16 Dec 2006 09:29:14 +0100
From: Marc Haber <mh+linux-kernel@zugschlus.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 file content corruption on ext3
Message-ID: <20061216082914.GA2983@torres.l21.ma.zugschlus.de>
References: <20061207155740.GC1434@torres.l21.ma.zugschlus.de> <4578465D.7030104@cfl.rr.com> <1165541892.1063.0.camel@sebastian.intellilink.co.jp> <20061208164206.GA1125@torres.l21.ma.zugschlus.de> <20061209104758.GA10261@atrey.karlin.mff.cuni.cz> <20061211190700.GA15165@torres.l21.ma.zugschlus.de> <20061214120341.GA17611@atrey.karlin.mff.cuni.cz> <20061215093034.GA16565@torres.l21.ma.zugschlus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061215093034.GA16565@torres.l21.ma.zugschlus.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 15, 2006 at 10:30:34AM +0100, Marc Haber wrote:
> Additionally, updating to 2.6.19.1
> allowed me to remove data=writeback without the issue re-surfacing. I
> suspect that the issue is fixed now.

Unfortunately, this suspicion proved wrong when the file was corrupted
again this morning.

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Mannheim, Germany  |  lose things."    Winona Ryder | Fon: *49 621 72739834
Nordisch by Nature |  How to make an American Quilt | Fax: *49 621 72739835
