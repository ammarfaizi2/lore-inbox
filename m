Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264931AbUEQIPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264931AbUEQIPt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 04:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264930AbUEQIPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 04:15:49 -0400
Received: from disk.smurf.noris.de ([192.109.102.53]:54732 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S264933AbUEQIOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 04:14:50 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: RE :[BUG 2.6.6mm2] bk-input is broken on AMD
Date: Mon, 17 May 2004 10:12:32 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.05.17.08.12.32.815021@smurf.noris.de>
References: <1084527815.6644.2.camel@bluerhyme.real3>
NNTP-Posting-Host: kiste.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Trace: server.smurf.noris.de 1084781551 31891 192.109.102.35 (17 May 2004 08:12:31 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Mon, 17 May 2004 08:12:31 +0000 (UTC)
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, FabF wrote:
> 	No response for that thread...Whose the right person to ctx for problem
> in bk-input ? No one noticed the same problem (keyboard non-functionning
> with bk-input in mm2) ?
> 
Happened to me yesterday a few times, including once after the cat walked
over the keyboard.  :-/

Unplugging the keyboard for a second made the problem go away.

2.6.6-mm2; no PS/2 mouse.

-- 
Matthias Urlichs
