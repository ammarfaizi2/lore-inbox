Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262737AbTENUzX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 16:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262798AbTENUzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 16:55:23 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47625 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262737AbTENUzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 16:55:22 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: The disappearing sys_call_table export.
Date: 14 May 2003 14:08:02 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b9ub7i$1a0$1@cesium.transmeta.com>
References: <1052689591.30506.9.camel@dhcp22.swansea.linux.org.uk> <MDEHLPKNGKAHNMBLJOLKEEFFCOAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <MDEHLPKNGKAHNMBLJOLKEEFFCOAA.davids@webmaster.com>
By author:    "David Schwartz" <davids@webmaster.com>
In newsgroup: linux.dev.kernel
> 
> 	I pointed out to them that any software mechanism I devised for shutting
> the system down would require that they had control over the system in order
> to invoke the mechanism.
> 
> 	They thought about that for a moment and were about to find that the system
> did not meet the requirements. I pointed out that anyone could pull the plug
> or network cable if needed or shut the system down at the switch and that
> this could be accomplished even if they lost control over the system and
> would certainly stop it from sending any information. They then agreed that
> the system met that requirement.
> 

"Sometimes it's possible to do in hardware what's impossible to do in
software."  Physical access is a powerful discriminator :)

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
