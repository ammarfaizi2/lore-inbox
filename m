Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262468AbVG2HHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262468AbVG2HHK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 03:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbVG2HGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 03:06:55 -0400
Received: from main.gmane.org ([80.91.229.2]:3558 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262468AbVG2HGV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 03:06:21 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: 2.6.13-rc3-mm3
Date: Fri, 29 Jul 2005 09:06:01 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.07.29.07.05.58.992113@smurf.noris.de>
References: <20050728025840.0596b9cb.akpm@osdl.org> <200507282111.32970.rjw@sisk.pl> <20050728121656.66845f70.akpm@osdl.org> <200507282340.57905.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Rafael J. Wysocki wrote:

> start a binary search

Note that if you work from my git import, git has a nice tree bisection
option.

That tree may be very helpful if the regression is hidden in one of the
git trees imported into -mm, as it allows you to pinpoint the exact change
 -- as opposed to "it happened somewhere in git-large-foobar-update.patch".

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
British education is probably the best in the world, if you can survive
it.  If you can't there is nothing left for you but the diplomatic corps.
		-- Peter Ustinov


