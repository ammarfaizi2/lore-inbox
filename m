Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263840AbTDJTlj (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 15:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263953AbTDJTlj (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 15:41:39 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21256 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263840AbTDJTlh (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 15:41:37 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: ATAPI cdrecord issue 2.5.67
Date: 10 Apr 2003 12:53:06 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b74i32$58g$1@cesium.transmeta.com>
References: <1049983308.888.5.camel@gregs> <1049984188.887.11.camel@gregs> <1049986391.599.6.camel@teapot.felipe-alfaro.com> <20030410193420.GD429@vitelus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030410193420.GD429@vitelus.com>
By author:    Aaron Lehmann <aaronl@vitelus.com>
In newsgroup: linux.dev.kernel
>
> On Thu, Apr 10, 2003 at 04:53:11PM +0200, Felipe Alfaro Solana wrote:
> > ide-scsi is still broken in 2.5... don't know if it's gonna get fixed or
> > deprecated as ATAPI support is working.
> 
> I don't like ide-scsi, but I need to use cdrdao to burn vcds. I wish
> someone would patch it to support 2.5.x ATAPI.
> 

I think ide-scsi needs to be supported for some time going forward.
After all, cdrecord, cdrdao, dvdrecord aren't going to be the only
applications.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
