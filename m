Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263521AbUCYSmW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 13:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263519AbUCYSmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 13:42:21 -0500
Received: from main.gmane.org ([80.91.224.249]:41893 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263521AbUCYSmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 13:42:20 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andreas Happe <news_0403@flatline.ath.cx>
Subject: Re: 2.6.5-rc2-mm2
Date: Thu, 25 Mar 2004 19:41:49 +0100
Message-ID: <slrnc669vd.1nf.news_0403@flatline.ath.cx>
References: <20040323232511.1346842a.akpm@osdl.org> <slrnc63mc2.18m.news_0403@flatline.ath.cx> <20040324130653.35cab65b.akpm@osdl.org> <20040324234659.GA1263@flatline.ath.cx>
Reply-To: Andreas Happe <news_0403@flatline.ath.cx>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: chello062178006202.3.11.tuwien.teleweb.at
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-03-24, Andreas Happe <andreashappe@flatline.ath.cx> wrote:
> .. will try booting without framebuffer later.

The system booted fine without framebuffer, some googling showed your
patch against drivers/char/vt.c which solved the problem (I'm not using
devfs).

posting can be found at newsid: <20040325092002.62edd8e7.akpm@osdl.org>.

	--Andreas

