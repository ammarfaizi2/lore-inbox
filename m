Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263735AbUHBVck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263735AbUHBVck (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 17:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263740AbUHBVck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 17:32:40 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:14236 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263735AbUHBVci (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 17:32:38 -0400
Message-ID: <b71082d804080214322e122806@mail.gmail.com>
Date: Mon, 2 Aug 2004 23:32:38 +0200
From: Bart Alewijnse <scarfboy@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HIGHMEM4G config for 1GB RAM on desktop?
In-Reply-To: <200408021602.34320.swsnyder@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200408021602.34320.swsnyder@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Last time I checked (which is already a somewhat older kernel) without
the 4G option you can only only address nine hundred something out of
of your thousand and twenty four megs.

And I believe the highmem thing creates some overhead.

So if you can live without the ~100mb, keep it off. If you want it,
turn it on. Other people will probably tell you te exact effects of
highmem. Probably in hard to decipher english too:)

I kept it off for ages, myself, basically because I rarely use all my
1GB. I think it's on now.

--Bart
