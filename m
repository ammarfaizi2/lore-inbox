Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbWIVLVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWIVLVG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 07:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbWIVLVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 07:21:06 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:13727 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750824AbWIVLVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 07:21:05 -0400
Subject: Re: 2.6.19 -mm merge plans
From: David Woodhouse <dwmw2@infradead.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rdunlap@xenotime.net
In-Reply-To: <Pine.LNX.4.61.0609221242070.791@yvahk01.tjqt.qr>
References: <20060920135438.d7dd362b.akpm@osdl.org>
	 <1158917046.24527.662.camel@pmac.infradead.org>
	 <1158919801.24527.668.camel@pmac.infradead.org>
	 <Pine.LNX.4.61.0609221242070.791@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Fri, 22 Sep 2006 12:20:37 +0100
Message-Id: <1158924037.24527.673.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-22 at 12:42 +0200, Jan Engelhardt wrote:
> If it is an unsigned long, it should neither be %ld nor %d, but %lu.

It'll never be negative.

-- 
dwmw2

