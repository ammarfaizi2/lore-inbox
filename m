Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267544AbUBSUNm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 15:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267546AbUBSUNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 15:13:42 -0500
Received: from intra.cyclades.com ([64.186.161.6]:5602 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S267544AbUBSUNj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 15:13:39 -0500
Date: Thu, 19 Feb 2004 17:54:58 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Elikster <elik@webspires.com>
Cc: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Oops - 2.4.24 Kernel
In-Reply-To: <1514338595.20040219112756@webspires.com>
Message-ID: <Pine.LNX.4.58L.0402191753050.7378@logos.cnet>
References: <1514338595.20040219112756@webspires.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 19 Feb 2004, Elikster wrote:

> Hello linux,
>
>   I been getting those Oops of late that seems to have started nearly a
> month ago and been persisting thoughout, dispite changing the kernels
> few times to try and shake this out.  Could this be the results of bad
> memory modules?

Yes this looks like bad hardware.

Verify the memory with memtest86.

> swap_free: Bad swap offset entry 3d000000
> kernel: kernel BUG at page_alloc.c:124!
