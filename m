Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262742AbTENUlq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 16:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262818AbTENUlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 16:41:46 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:264 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262742AbTENUlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 16:41:45 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] 2.5.68 FUTEX support should be optional
Date: 14 May 2003 13:54:09 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b9uadh$16e$1@cesium.transmeta.com>
References: <Pine.LNX.4.44.0305141246180.27329-100000@home.transmeta.com> <Pine.LNX.4.55.0305141342030.4539@bigblue.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.55.0305141342030.4539@bigblue.dev.mcafeelabs.com>
By author:    Davide Libenzi <davidel@xmailserver.org>
In newsgroup: linux.dev.kernel
> 
> Not only. Like Ulrich was saying, the config documentation should heavily
> warn the wild config guy about the consequences of a 'NO' over there.
> 

How about creating a master option like we have for experimental?
Something like "Allow removal of essential components?" (CONFIG_EMBEDDED)

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
