Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263455AbTDGO4d (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 10:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263492AbTDGO4d (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 10:56:33 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46860 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263455AbTDGOzc (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 10:55:32 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Re[2]: 845GE Chipset severe performance problems
Date: 7 Apr 2003 08:06:44 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b6s464$i3t$1@cesium.transmeta.com>
References: <188481168784.20030329130300@btinternet.com> <153495685337.20030329170457@btinternet.com> <1049039985.14686.11.camel@dhcp22.swansea.linux.org.uk> <20030401204850.A6890@bitwizard.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030401204850.A6890@bitwizard.nl>
By author:    Rogier Wolff <R.E.Wolff@BitWizard.nl>
In newsgroup: linux.dev.kernel
> 
> 504Mb RAM? That sounds like a 512Mb ram with 8Mb "shared"
> video-ram. 845? Sounds like one of those "everything integrated"
> chipsets. performance problems? Do you happen to have the video in a
> high-bandwidth mode?????
> 

Sure enough it is, and I can personally vouch for the fact that my
845GE system (a Shuttle-X box) got a lot nicer after I dropped a
Radeon 9000 into the AGP slot :)

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
