Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263803AbTL2TjO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 14:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263836AbTL2TjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 14:39:14 -0500
Received: from intra.cyclades.com ([64.186.161.6]:12511 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263803AbTL2TjN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 14:39:13 -0500
Date: Mon, 29 Dec 2003 17:31:18 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Elwin Eliazer <elwinietf@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel panic while upgrading from 2.4.20-6 to 2.4.22
In-Reply-To: <20031225023952.32560.qmail@web80710.mail.yahoo.com>
Message-ID: <Pine.LNX.4.58L.0312281944370.15976@logos.cnet>
References: <20031225023952.32560.qmail@web80710.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 24 Dec 2003, Elwin Eliazer wrote:

> ds: no socket drivers loaded!
> VFS: Cannot open root device "LABEL=/" or 00:00
> Please append a correct "root=" boot option
> Kernel panic: VFS: Unable to mount root fs on 00:00

If you want to use the vanilla kernel, you need to use "root=/dev/xxx"
instead "LABEL=/".

