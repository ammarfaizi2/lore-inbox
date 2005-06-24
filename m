Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263268AbVFXLNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263268AbVFXLNj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 07:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263251AbVFXLJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 07:09:14 -0400
Received: from main.gmane.org ([80.91.229.2]:27270 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S263240AbVFXLFn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 07:05:43 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: Finding what change broke ARM
Date: Fri, 24 Jun 2005 13:04:06 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.06.24.11.04.04.815183@smurf.noris.de>
References: <20050624101951.B23185@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Russell King wrote:

> With git... ?  We don't have per-file revision history so...

That doesn't really matter -- "cg-log FILE" will show you the changes
which change FILE. Works with subdirectories too.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
"Of all the many, many different versions of gods in the world;
 Christians seem to have sought out the most unmoving, uncompromising,
 hateful, and murderous version they could find to give their worship
 too. A sad sorry lot they be indeed."
                    [Michael Suetkamp]


