Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263949AbTFWXc3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 19:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264060AbTFWXc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 19:32:29 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27141 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263949AbTFWXc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 19:32:26 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Crusoe's performance on linux?
Date: 23 Jun 2003 16:46:08 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bd83g0$bce$1@cesium.transmeta.com>
References: <3EF1E6CD.4040800@thai.com> <20030619221126.B3287@ucw.cz> <3EF67AD4.4040601@thai.com> <20030623102623.A18000@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030623102623.A18000@ucw.cz>
By author:    Vojtech Pavlik <vojtech@suse.cz>
In newsgroup: linux.dev.kernel
> 
> Desktop - 1.1 GHz Athlon Tbird 512M RAM, using disk -> 3.7 min
> 
> This is with gcc 2.95.2, which may give it an unfair advantage, though.
> Or is something else wrong here?
> 

gcc has been getting *massively* slower with every version since 2.7.2
or so, so it's important to compare the same gcc version.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
