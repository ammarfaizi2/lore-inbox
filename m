Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267268AbUBMWxy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 17:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267277AbUBMWxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 17:53:54 -0500
Received: from pop.gmx.net ([213.165.64.20]:60875 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267268AbUBMWvq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 17:51:46 -0500
X-Authenticated: #20450766
Date: Fri, 13 Feb 2004 23:39:53 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Brad Cramer <bcramer@callahanfuneralhome.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: sym53c8xx_2 driver and tekram dc-390u2w kernel-2.6.x
In-Reply-To: <004e01c3f243$8eadc7b0$6501a8c0@office>
Message-ID: <Pine.LNX.4.44.0402132334460.4537-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Feb 2004, Brad Cramer wrote:

>  I can not get my scsi hd to work with my tekram dc-390u2w controller and
> the sym53c8xx_2 driver under kernel-2.6.2. Everything works great using
> kernel-2.4.28 and sym53c8xx driver so I know this is not a hardware issue
> with the disk. I have built the sym53c8xx_2 driver into the kernel and have

Can you send your dmesg output when attempting to boot a 2.6.x kernel? You
might want to move (or, at least, CC) this discussion to the linux-scsi
(linux-scsi@vger.kernel.org) list.

Guennadi
---
Guennadi Liakhovetski


