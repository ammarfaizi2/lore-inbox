Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbULWPCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbULWPCy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 10:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbULWPCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 10:02:54 -0500
Received: from ns.tasking.nl ([195.193.207.2]:1035 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id S261253AbULWOys (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 09:54:48 -0500
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
Reply-To: dick.streefland@altium.nl (Dick Streefland)
Organization: Altium BV
X-Face: "`*@3nW;mP[=Z(!`?W;}cn~3M5O_/vMjX&Pe!o7y?xi@;wnA&Tvx&kjv'N\P&&5Xqf{2CaT 9HXfUFg}Y/TT^?G1j26Qr[TZY%v-1A<3?zpTYD5E759Q?lEoR*U1oj[.9\yg_o.~O.$wj:t(B+Q_?D XX57?U,#b,iM$[zX'I(!'VCQM)N)x~knSj>M*@l}y9(tK\rYwdv%~+&*jV"epphm>|q~?ys:g:K#R" 2PuAzy-N9cKM<Ml/%yPQxpq"Ttm{GzBn-*:;619QM2HLuRX4]~361+,[uFp6f"JF5R`y
References: <41CABBF1.6050304@globaledgesoft.com>
From: dick.streefland@altium.nl (Dick Streefland)
Subject: Re: Significance of  variable arguments
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Host: 172.17.1.66
Message-ID: <78e9.41cadbfa.a0385@altium.nl>
Date: Thu, 23 Dec 2004 14:53:46 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

krishna <krishna.c@globaledgesoft.com> wrote:
| Can any one tell me a source which explains the significance of variable 
| arguments.
| 
| eg : struct task_struct *kthread_create(int (*threadfn)(void *data),
|                                    void *data,
|                                    const char namefmt[],
|                                    ...)

man stdarg

-- 
Dick Streefland                      ////                      Altium BV
dick.streefland@altium.nl           (@ @)          http://www.altium.com
--------------------------------oOO--(_)--OOo---------------------------

