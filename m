Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbTKUXjc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 18:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbTKUXjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 18:39:32 -0500
Received: from ns.tasking.nl ([195.193.207.2]:55823 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id S261755AbTKUXjb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 18:39:31 -0500
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
Reply-To: dick.streefland@xs4all.nl (Dick Streefland)
Organization: none
X-Face: "`*@3nW;mP[=Z(!`?W;}cn~3M5O_/vMjX&Pe!o7y?xi@;wnA&Tvx&kjv'N\P&&5Xqf{2CaT 9HXfUFg}Y/TT^?G1j26Qr[TZY%v-1A<3?zpTYD5E759Q?lEoR*U1oj[.9\yg_o.~O.$wj:t(B+Q_?D XX57?U,#b,iM$[zX'I(!'VCQM)N)x~knSj>M*@l}y9(tK\rYwdv%~+&*jV"epphm>|q~?ys:g:K#R" 2PuAzy-N9cKM<Ml/%yPQxpq"Ttm{GzBn-*:;619QM2HLuRX4]~361+,[uFp6f"JF5R`y
References: <2535.3fbe9484.4f0e6@altium.nl> <2535.3fbe9484.4f0e6@altium.nl> <200311220001.47992.bzolnier@elka.pw.edu.pl>
From: spam@streefland.xs4all.nl (Dick Streefland)
Subject: Re: IDE lockup after floppy access
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Host: 172.17.1.66
Message-ID: <3a59.3fbea202.a0099@altium.nl>
Date: Fri, 21 Nov 2003 23:38:42 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:
| 
| Does disabling CONFIG_PREEMPT cure the problem?

No, I just tried without CONFIG_PREEMPT, but it still hangs.

-- 
Dick Streefland                    ////               De Bilt
dick.streefland@xs4all.nl         (@ @)       The Netherlands
------------------------------oOO--(_)--OOo------------------

