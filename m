Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272966AbTHNSsF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 14:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275077AbTHNSsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 14:48:05 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21769 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S272966AbTHNSsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 14:48:02 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: multibooting the linux kernel
Date: 14 Aug 2003 11:47:27 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bhglfv$h1j$1@cesium.transmeta.com>
References: <3F396C04.90608@home.ro>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3F396C04.90608@home.ro>
By author:    Nufarul Alb <nufarul.alb@home.ro>
In newsgroup: linux.dev.kernel
>
> There is a patch for the kernel that make it able to preload modules 
> before the acutal booting.
> 
> I wonder if this feature will be included in the official linux kernel.
> 

Use initramfs.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
