Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265110AbUGCNvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265110AbUGCNvh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 09:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265112AbUGCNve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 09:51:34 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:53968 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S265110AbUGCNvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 09:51:32 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: two questions
Date: Sat, 03 Jul 2004 15:47:18 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.07.03.13.47.17.173440@smurf.noris.de>
References: <BAY16-F33zN3arTZiqp000060ee@hotmail.com>
NNTP-Posting-Host: kiste.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: server.smurf.noris.de 1088862438 24172 192.109.102.35 (3 Jul 2004 13:47:18 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Sat, 3 Jul 2004 13:47:18 +0000 (UTC)
To: kartik_me@hotmail.com (kartikey bhatt)
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, kartikey bhatt wrote:

> (1) in bsd when a socket is created, the process
> creating the socket is passed as a structure
> to so_create call. in linux how can we have
> this mechanism by which when a socket is created
> we can access the task_t of the process creating the
> socket?
> 
> (2) given the sk_buff* how to lookup the associated
> socket?
> 
Those questions imply that you want to do "something".
Please tell us what that "something" is.

-- 
Matthias Urlichs
