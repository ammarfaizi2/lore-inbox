Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263435AbUA3TLo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 14:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263486AbUA3TLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 14:11:44 -0500
Received: from intra.cyclades.com ([64.186.161.6]:16314 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263435AbUA3TLm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 14:11:42 -0500
Date: Fri, 30 Jan 2004 17:11:20 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Xose Vazquez Perez <xose@wanadoo.es>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Compile Regression] 2.4.25-pre8: 126 warnings 0 errors
In-Reply-To: <401A9F2B.1060400@wanadoo.es>
Message-ID: <Pine.LNX.4.58L.0401301700420.2675@logos.cnet>
References: <401A9F2B.1060400@wanadoo.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a shame. These warnings piled up during time.

It is very likely that all of them are harmless,
but they need to be fixed.

Will find to look into some of them. Help is appreciated.

On Fri, 30 Jan 2004, Xose Vazquez Perez wrote:

> hi,
>
>  kernel: 2.4.25-pre8
>
>  distribution : RHL 9
>  gcc:    3.2.2
>
> [...]
>
> Kernel build of original configuration:
>    Making bzImage (oldconfig): 15 warnings, 0 errors
>    Making modules (oldconfig): 126 warnings, 0 errors
>
> Warning Summary (individual module builds):
>
>    drivers/atm: 1 warnings, 0 errors
>    drivers/char: 10 warnings, 0 errors
>    drivers/ide: 2 warnings, 0 errors
>    drivers/ieee1394: 1 warnings, 0 errors
>    drivers/isdn: 25 warnings, 0 errors
>    drivers/media: 1 warnings, 0 errors
>    drivers/mtd: 10 warnings, 0 errors
>    drivers/net: 10 warnings, 0 errors
>    drivers/net: 2 warnings, 0 errors
>    drivers/pcmcia: 2 warnings, 0 errors
>    drivers/scsi: 14 warnings, 0 errors
>    drivers/scsi/aacraid: 2 warnings, 0 errors
>    drivers/scsi/pcmcia: 2 warnings, 0 errors
>    drivers/sound: 5 warnings, 0 errors
>    drivers/telephony: 2 warnings, 0 errors
>    drivers/usb: 6 warnings, 0 errors
>    drivers/video: 9 warnings, 0 errors
>    drivers/video/matrox: 5 warnings, 0 errors
>    drivers/video/riva: 1 warnings, 0 errors
>    fs/befs: 4 warnings, 0 errors
>    fs/hfs: 2 warnings, 0 errors
>    fs/intermezzo: 1 warnings, 0 errors
>    fs/nfs: 2 warnings, 0 errors
>    fs/xfs: 1 warnings, 0 errors
>    net: 7 warnings, 0 errors
