Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751504AbVJRVTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbVJRVTZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 17:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbVJRVTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 17:19:25 -0400
Received: from [193.22.164.111] ([193.22.164.111]:49798 "EHLO
	vserver151.vserver151.serverflex.de") by vger.kernel.org with ESMTP
	id S1751504AbVJRVTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 17:19:25 -0400
Date: Tue, 18 Oct 2005 23:19:53 +0200
To: Horms <horms@verge.net.au>
Cc: linux-kernel@vger.kernel.org, security@kernel.org,
       secure-testing-team@lists.alioth.debian.org, 334113@bugs.debian.org,
       Rudolf Polzer <debian-ne@durchnull.de>,
       Alastair McKinstry <mckinstry@debian.org>, team@security.debian.org
Subject: Re: [Secure-testing-team] kernel allows loadkeys to be used by any user, allowing for local root compromise
Message-ID: <20051018211953.GA5374@informatik.uni-bremen.de>
References: <E1EQofT-0001WP-00@master.debian.org> <20051018044146.GF23462@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051018044146.GF23462@verge.net.au>
User-Agent: Mutt/1.5.11
From: Moritz Muehlenhoff <jmm@inutil.org>
X-SA-Exim-Connect-IP: 82.83.201.0
X-SA-Exim-Mail-From: jmm@inutil.org
X-SA-Exim-Scanned: No (on vserver151.vserver151.serverflex.de); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horms wrote:
> > The non-suid command "loadkeys" can be used by any local user having
> > console access. It does not just apply to the current virtual console
> > but to all virtual consoles and its effect persists even after logout.

This has been assigned CAN-2005-3257.

Cheers,
        Moritz
