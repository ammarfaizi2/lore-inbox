Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbVLORX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbVLORX6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 12:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbVLORX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 12:23:58 -0500
Received: from ns.tasking.nl ([195.193.207.2]:25035 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id S1750812AbVLORX5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 12:23:57 -0500
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
Reply-To: dick.streefland@altium.nl (Dick Streefland)
Organization: Altium BV
X-Face: "`*@3nW;mP[=Z(!`?W;}cn~3M5O_/vMjX&Pe!o7y?xi@;wnA&Tvx&kjv'N\P&&5Xqf{2CaT 9HXfUFg}Y/TT^?G1j26Qr[TZY%v-1A<3?zpTYD5E759Q?lEoR*U1oj[.9\yg_o.~O.$wj:t(B+Q_?D XX57?U,#b,iM$[zX'I(!'VCQM)N)x~knSj>M*@l}y9(tK\rYwdv%~+&*jV"epphm>|q~?ys:g:K#R" 2PuAzy-N9cKM<Ml/%yPQxpq"Ttm{GzBn-*:;619QM2HLuRX4]~361+,[uFp6f"JF5R`y
References: <20051215135812.14578.qmail@science.horizon.com> <Pine.LNX.4.64.0512150752240.3292@g5.osdl.org> <Pine.LNX.4.64.0512150752240.3292@g5.osdl.org> <20051215165255.GA5510@harddisk-recovery.com>
From: dick.streefland@altium.nl (Dick Streefland)
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Host: 172.17.1.66
Message-ID: <4115.43a1a67f.21762@altium.nl>
Date: Thu, 15 Dec 2005 17:23:11 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw <erik@harddisk-recovery.com> wrote:
| Just FYI, according to Dijkstra[1] V means "verhoog" which is dutch for
| "increase". P means "prolaag" which isn't a dutch word, just something
| Dijkstra invented. I guess he did that because "decrease" is "verlaag"
| in dutch and that would give you the confusing V() and V()
| operations...
| 
| Other explanations you see in dutch CS courses are "passeer" (pass),
| "probeer" (try), "vrijgave" (unlock).

As far as I can remember, P() stands for "pakken" (grab) and V()
stands for "vrijgeven" (release).

-- 
Dick Streefland                      ////                      Altium BV
dick.streefland@altium.nl           (@ @)          http://www.altium.com
--------------------------------oOO--(_)--OOo---------------------------

