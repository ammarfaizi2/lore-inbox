Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbTIVXIT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 19:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261883AbTIVXIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 19:08:18 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47882 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261808AbTIVXIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 19:08:17 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: compiler warnings and syscall macros
Date: 22 Sep 2003 16:08:04 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bknvck$ko9$1@cesium.transmeta.com>
References: <3F6F6B1B.9040609@nortelnetworks.com> <200309222253.PAA21087@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200309222253.PAA21087@cesium.transmeta.com>
By author:    "H. Peter Anvin" <hpa@zytor.com>
In newsgroup: linux.dev.kernel
> 
> Just do:
> 
> __sc_ret = -1UL;
> 
> 	-hpa

... sorry for the dupes; client said post hadn't happened when in fact
it had.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
