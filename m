Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261446AbVARWFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbVARWFe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 17:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbVARWFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 17:05:34 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:62480 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261446AbVARWF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 17:05:26 -0500
To: kladit@t-online.de (Klaus Dittrich)
Cc: chaosite@gmail.com, Mark Watts <m.watts@eris.qinetiq.com>,
       linux-kernel@vger.kernel.org
X-Message-Flag: Warning: May contain useful information
References: <20050117153646.GA25273@xeon2.local.here>
	<200501171609.15054.m.watts@eris.qinetiq.com>
	<41EBE54B.1010401@xeon2.local.here>
	<200501171632.26443.m.watts@eris.qinetiq.com>
	<41EBE974.8050309@gmail.com> <41EBF0CC.7050601@xeon2.local.here>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 18 Jan 2005 14:04:41 -0800
In-Reply-To: <41EBF0CC.7050601@xeon2.local.here> (Klaus Dittrich's message
 of "Mon, 17 Jan 2005 18:07:24 +0100")
Message-ID: <523bwybdhi.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: brought up 4 cpu's
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: No (on eddore); Unknown failure
X-OriginalArrivalTime: 18 Jan 2005 22:04:44.0307 (UTC) FILETIME=[B77EFE30:01C4FDA9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Same problem here: a bk tree pulled this morning won't boot on my
system.  It freezes at "Brought up 4 CPUs."  This is a dual Nocona
system (with HT of course) running an x86_64 kernel.  An i386 kernel
actually boots OK.

.configs etc. available on request....

 - R.

