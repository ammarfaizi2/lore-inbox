Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130648AbRAWUcJ>; Tue, 23 Jan 2001 15:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131465AbRAWUb7>; Tue, 23 Jan 2001 15:31:59 -0500
Received: from adsl-63-202-13-20.dsl.snfc21.pacbell.net ([63.202.13.20]:60425
	"EHLO earth.zigamorph.net") by vger.kernel.org with ESMTP
	id <S130648AbRAWUbt>; Tue, 23 Jan 2001 15:31:49 -0500
Date: Tue, 23 Jan 2001 20:32:06 +0000 (UTC)
From: Adam Fritzler <mid@earth.zigamorph.net>
To: Alan Olsen <alan@clueserver.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Probably Off-topic Question...
In-Reply-To: <Pine.LNX.4.10.10101222129310.3031-100000@clueserver.org>
Message-ID: <Pine.LNX.4.21.0101232030360.26932-100000@earth.zigamorph.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jan 2001, Alan Olsen wrote:

> BTW, the Yamaha sound chip in the Vaio is supported under Alsa.  You might
> ask them what they did to get it to work, so it can be included in the
> stock kernel. (Or maybe it already has and I have just not been looking.)

The ymf_pci driver in any recent kernel works just fine on the yamaha in
the vaio's.  That is, unless you want to record.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
