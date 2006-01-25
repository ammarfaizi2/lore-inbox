Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbWAYWVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbWAYWVL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 17:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWAYWVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 17:21:11 -0500
Received: from main.gmane.org ([80.91.229.2]:35043 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932171AbWAYWVK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 17:21:10 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: OOM Killer killing whole system
Date: Wed, 25 Jan 2006 23:20:42 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2006.01.25.22.20.40.283831@smurf.noris.de>
References: <1137337516.11767.50.camel@localhost> <1137793685.11771.58.camel@localhost> <20060120145006.0a773262.akpm@osdl.org> <200601201819.58366.chase.venters@clientec.com> <20060120165031.7773d9c4.akpm@osdl.org> <1137806248.4122.11.camel@mulgrave> <1137814181.11771.70.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Cc: linux-scsi@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Anton Titov wrote:

> Just to mention, that 2.6.14.2 does not have this problem:

That's good, in that a couple of iterations with "git bisect" should
be able to pinpoint the bug.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
:hack on: vt. [very common] To {hack}; implies that the subject is some
   pre-existing hunk of code that one is evolving, as opposed to something
   one might {hack up}.


