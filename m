Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbWAEWDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbWAEWDT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 17:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWAEWDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 17:03:18 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:12169 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932239AbWAEWDQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 17:03:16 -0500
Date: Thu, 5 Jan 2006 23:03:09 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Kay Sievers <kay.sievers@vrfy.org>
cc: Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
Subject: Re: 80 column line limit?
In-Reply-To: <20060105211438.GA1408@vrfy.org>
Message-ID: <Pine.LNX.4.61.0601052301270.27662@yvahk01.tjqt.qr>
References: <20060105130249.GB29894@vrfy.org>
 <84144f020601050532l56c15be1i4938a84f6c212960@mail.gmail.com>
 <20060105211438.GA1408@vrfy.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> And your nesting is too deep, it should be fixed.
>
>It's not about nesting, if that's the reason, the number of tabs
>should get a maximum specified instead.
>
Or we could have the tab width lowered, but I doubt
Linus would accept that :)


Jan
-- 
