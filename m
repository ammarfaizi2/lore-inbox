Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268410AbUJMFxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268410AbUJMFxO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 01:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268445AbUJMFxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 01:53:14 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:51900 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S268410AbUJMFv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 01:51:27 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: single linked list header in kernel?
Date: Wed, 13 Oct 2004 07:50:50 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.10.13.05.50.46.937470@smurf.noris.de>
References: <416C1F48.4040407@nortelnetworks.com>
NNTP-Posting-Host: kiste.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: server.smurf.noris.de 1097646650 12500 192.109.102.35 (13 Oct 2004 05:50:50 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Wed, 13 Oct 2004 05:50:50 +0000 (UTC)
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Chris Friesen wrote:

> Is there any plan to put a singly-linked list implementation into the kernel?  I 
> mean sure its simple, but we've got the double-linked one there...
> 
> It's been brought up periodically, but nothing seems to have come of it.
> 
What would you use one for? Just putting stuff in the kernel because it's
not there yet is nonsense.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de

