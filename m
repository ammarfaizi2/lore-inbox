Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318312AbSGRS4T>; Thu, 18 Jul 2002 14:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318313AbSGRS4T>; Thu, 18 Jul 2002 14:56:19 -0400
Received: from divine.city.tvnet.hu ([195.38.100.154]:56073 "EHLO
	divine.city.tvnet.hu") by vger.kernel.org with ESMTP
	id <S318312AbSGRS4S>; Thu, 18 Jul 2002 14:56:18 -0400
Date: Thu, 18 Jul 2002 20:01:08 +0200 (MEST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Robert Love <rml@tech9.net>, <linux-mm@kvack.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] strict VM overcommit for stock 2.4
In-Reply-To: <1027022323.8154.38.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.30.0207181956200.30902-100000@divine.city.tvnet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 18 Jul 2002, Alan Cox wrote:
> Adjusting the percentages to have a root only zone is doable. It helps
> in some conceivable cases but not all. Do people think its important, if
> so I'll add it

"Why isn't in the kernel?" was the other FAQ I got besides "when it
will be ported to 2.4?" [about the reserved root vm patch I mentioned
in my other email].

	Szaka

