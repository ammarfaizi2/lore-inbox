Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbUAXWkM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 17:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbUAXWkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 17:40:12 -0500
Received: from user-119ahgg.biz.mindspring.com ([66.149.70.16]:33760 "EHLO
	mail.home") by vger.kernel.org with ESMTP id S261890AbUAXWkG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 17:40:06 -0500
From: Eric <eric@cisu.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernels > 2.6.1-mm3 do not boot.
Date: Sat, 24 Jan 2004 16:39:23 -0600
User-Agent: KMail/1.5.94
References: <200401232253.08552.eric@cisu.net> <200401240011.36074.eric@cisu.net>
In-Reply-To: <200401240011.36074.eric@cisu.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401241639.23479.eric@cisu.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 24 January 2004 00:11, Eric wrote:
> On Friday 23 January 2004 22:53, Eric wrote:
> > Hello.
> > 	I am unable to boot with kernels greater than 2.6.1-mm3. I do not recall
> > if mm3 booted or not, but I know for sure that mm4 and rc1-mm1 are broken
> > for me. When I try to boot the selected kernel I see uncompressing
> > kernel.....then booting kernel.
>
> Very sorry, here is the .config i MEANT to attach but got distracted.

Confirmed, the same problem when I recompiled and tried (just now)

2.6.1-rc1-mm1
2.6.1-rc1-mm2

What changed? Why am I suddenly locked out of all newer kernel versions?
I am using vanilla sources with nothing other than mm patches.

-------------------------
Eric Bambach
Eric at cisu dot net
-------------------------
