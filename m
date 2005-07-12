Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262361AbVGLE4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbVGLE4V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 00:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262364AbVGLE4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 00:56:21 -0400
Received: from hera.kernel.org ([209.128.68.125]:22733 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262361AbVGLE4P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 00:56:15 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: zImage on 2.6?
Date: Tue, 12 Jul 2005 04:55:57 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <davigt$8e6$1@terminus.zytor.com>
References: <20050503223148.GF12199@animx.eu.org> <Pine.LNX.4.44.0505032026360.1510-100000@sleekfreak.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1121144157 8647 127.0.0.1 (12 Jul 2005 04:55:57 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Tue, 12 Jul 2005 04:55:57 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.44.0505032026360.1510-100000@sleekfreak.ath.cx>
By author:    shogunx <shogunx@sleekfreak.ath.cx>
In newsgroup: linux.dev.kernel
>
> On Tue, 3 May 2005, Wakko Warner wrote:
> 
> On an interesting side note, when running linux on IBM rs/6000, which is
> a ppc64 machine, one must use a zImage kernel dd'ed into a small PReP
> partition to boot the machine... bzImage kernels will not work.
> 

zImage/bzImage probably means something completely different on ppc.

	-hpa
