Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265920AbUBKRBO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 12:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265954AbUBKRBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 12:01:14 -0500
Received: from ns.tasking.nl ([195.193.207.2]:17935 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id S265920AbUBKRBM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 12:01:12 -0500
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
Reply-To: dick.streefland@altium.nl (Dick Streefland)
Organization: Altium BV
X-Face: "`*@3nW;mP[=Z(!`?W;}cn~3M5O_/vMjX&Pe!o7y?xi@;wnA&Tvx&kjv'N\P&&5Xqf{2CaT 9HXfUFg}Y/TT^?G1j26Qr[TZY%v-1A<3?zpTYD5E759Q?lEoR*U1oj[.9\yg_o.~O.$wj:t(B+Q_?D XX57?U,#b,iM$[zX'I(!'VCQM)N)x~knSj>M*@l}y9(tK\rYwdv%~+&*jV"epphm>|q~?ys:g:K#R" 2PuAzy-N9cKM<Ml/%yPQxpq"Ttm{GzBn-*:;619QM2HLuRX4]~361+,[uFp6f"JF5R`y
References: <Pine.LNX.4.44.0402111448320.10791-100000@gaia.cela.pl> <Pine.LNX.4.44.0402111448320.10791-100000@gaia.cela.pl> <200402111604.49082.vda@port.imtp.ilyichevsk.odessa.ua>
From: spam@altium.nl (Dick Streefland)
Subject: Re: printk and long long
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Host: 172.17.1.66
Message-ID: <29b8.402a5f8c.66fe5@altium.nl>
Date: Wed, 11 Feb 2004 16:59:56 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vda <vda@port.imtp.ilyichevsk.odessa.ua> wrote:
| Note that long long is not specified in ANSI C and therefore
| not portable to all architectures.

ANSI C corresponds to ISO-C90, which is 14 years old now. The current
C standard is ISO-C99, which specifies "ll" as the length modifier for
"long long" integer arguments.

-- 
Dick Streefland                      ////                      Altium BV
dick.streefland@altium.nl           (@ @)          http://www.altium.com
--------------------------------oOO--(_)--OOo---------------------------

