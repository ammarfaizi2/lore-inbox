Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264007AbTDOAMB (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 20:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264008AbTDOAMB (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 20:12:01 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26123 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264007AbTDOAMA (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 20:12:00 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: BUGed to death
Date: 14 Apr 2003 17:23:42 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b7fjee$ta8$1@cesium.transmeta.com>
References: <80690000.1050351598@flay> <20030414210006.GA7831@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030414210006.GA7831@suse.de>
By author:    Dave Jones <davej@codemonkey.org.uk>
In newsgroup: linux.dev.kernel
> 
> The sort of folks who would worry about that very last 1% are the
> sort of people that would more than likely hit these BUGs as they're
> really stressing things.
> 
> Losing a bunch of potential reports (and possibly doing bad things),
> in the name of a 1% performance boost doesn't sound too productive to me.
> 

It's useful to have the hooks to actually *measure* the overhead,
though.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
