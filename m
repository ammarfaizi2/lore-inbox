Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269253AbTCBUGi>; Sun, 2 Mar 2003 15:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269255AbTCBUGi>; Sun, 2 Mar 2003 15:06:38 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18700 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269253AbTCBUGg>; Sun, 2 Mar 2003 15:06:36 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] remove DEVFS_FL_AUTO_DEVNUM
Date: 2 Mar 2003 12:16:39 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b3tor7$uqu$1@cesium.transmeta.com>
References: <20030301190724.B1900@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030301190724.B1900@lst.de>
By author:    Christoph Hellwig <hch@lst.de>
In newsgroup: linux.dev.kernel
> 
> Rationale:  while dynamic major/minors are a good idea, devfs is the
> wrong layer to do it because all code relying on it would break with
> out devfs.
> 

Your first clause here is a *highly* questionable statement...

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: cris ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
