Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932408AbVLQK0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbVLQK0y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 05:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbVLQK0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 05:26:54 -0500
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:20188 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S932408AbVLQK0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 05:26:52 -0500
Date: Sat, 17 Dec 2005 11:26:43 +0100 (CET)
From: Bodo Eggert <7eggert@gmx.de>
To: Dave Jones <davej@redhat.com>
cc: 7eggert@gmx.de, Kyle Moffett <mrmacman_g4@mac.com>,
       linux-kernel@vger.kernel.org, Alex Davis <alex14641@yahoo.com>
Subject: Re: [2.6 patch] i386: always use 4k stacks
In-Reply-To: <20051216180816.GC2821@redhat.com>
Message-ID: <Pine.LNX.4.58.0512171125440.12637@be1.lrz>
References: <5kh6K-7KC-3@gated-at.bofh.it> <5kiFR-1mi-11@gated-at.bofh.it>
 <E1EnDOo-0006Gd-Na@be1.lrz> <20051216180816.GC2821@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Dec 2005, Dave Jones wrote:
> On Fri, Dec 16, 2005 at 12:05:18PM +0100, Bodo Eggert wrote:

>  > ACK. So where is the driver for the Netgear WG511 Softmac card I'm supposed
>  > to test? I bought this card because it was labled as being supported, and it
>  > turned out that it wasn't, and just nobody cared to update the list of
>  > supported cards with the warning about the unsupported variant.
> 
> There are two models of that card with the same name.
> The one made in taiwan is a prism54, the one made in china is
> something else.  I guess yours is made in China ?

Yes.
-- 
Saying your system is secure should be considered the same as saying your food
is too hot. Its a temporary condition which is going away even as you speak.
	-- Gandalf Parker
