Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262267AbVAQROT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262267AbVAQROT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 12:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262294AbVAQROT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 12:14:19 -0500
Received: from main.gmane.org ([80.91.229.2]:40108 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262267AbVAQRNJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 12:13:09 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: 2.6.11-rc1-mm1
Date: Mon, 17 Jan 2005 18:04:51 +0100
Organization: {M:U} IT-Consulting
Message-ID: <pan.2005.01.17.17.04.50.629545@smurf.noris.de>
References: <20050114002352.5a038710.akpm@osdl.org> <1105707861.6471.1.camel@localhost> <20050114103534.4f4a24be.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4E   G?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,   Andrew Morton schrub am Fri, 14 Jan 2005 10:35:34 -0800:

> What filesystem(s) do you use, and why?

sshfs (best idea for file access through firewalls).
gmailfs (best free off-site backup facility).
Will use encfs as soon as FUSE is in mainline
  (I'm using cryptoloop now, but that's not sanely backupable.)

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de


