Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263805AbTEGPGz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 11:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263811AbTEGPGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 11:06:55 -0400
Received: from ns.tasking.nl ([195.193.207.2]:11272 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id S263805AbTEGPGy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 11:06:54 -0400
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
Reply-To: dick.streefland@altium.nl (Dick Streefland)
Organization: Altium BV
X-Face: "`*@3nW;mP[=Z(!`?W;}cn~3M5O_/vMjX&Pe!o7y?xi@;wnA&Tvx&kjv'N\P&&5Xqf{2CaT 9HXfUFg}Y/TT^?G1j26Qr[TZY%v-1A<3?zpTYD5E759Q?lEoR*U1oj[.9\yg_o.~O.$wj:t(B+Q_?D XX57?U,#b,iM$[zX'I(!'VCQM)N)x~knSj>M*@l}y9(tK\rYwdv%~+&*jV"epphm>|q~?ys:g:K#R" 2PuAzy-N9cKM<Ml/%yPQxpq"Ttm{GzBn-*:;619QM2HLuRX4]~361+,[uFp6f"JF5R`y
References: <20030507141458.B30005@flint.arm.linux.org.uk>
From: spam@altium.nl (Dick Streefland)
Subject: Re: The magical mystical changing ethernet interface order
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Host: 172.17.1.66
Message-ID: <6632.3eb923bb.15701@altium.nl>
Date: Wed, 07 May 2003 15:18:19 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk@arm.linux.org.uk> wrote:
| Its rather annoying when your dhcpd starts on the wrong interface.

You can avoid this by assigning new interface names with "nameif".

-- 
Dick Streefland                      ////                      Altium BV
dick.streefland@altium.nl           (@ @)          http://www.altium.com
--------------------------------oOO--(_)--OOo---------------------------

