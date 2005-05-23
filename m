Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbVEWLqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbVEWLqR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 07:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbVEWLqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 07:46:17 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:52419 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261225AbVEWLqP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 07:46:15 -0400
Date: Mon, 23 May 2005 13:45:56 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Herbert Xu <herbert@gondor.apana.org.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: route procfile problems
In-Reply-To: <20050523025126.GA23544@gondor.apana.org.au>
Message-ID: <Pine.LNX.4.61.0505231344590.30608@yvahk01.tjqt.qr>
References: <E1DZlK1-0005Js-00@gondolin.me.apana.org.au>
 <Pine.LNX.4.61.0505221009280.21187@yvahk01.tjqt.qr> <20050522081918.GA20588@gondor.apana.org.au>
 <Pine.LNX.4.61.0505221429570.9671@yvahk01.tjqt.qr> <20050523025126.GA23544@gondor.apana.org.au>
X-Copyright: "Copyright (C) by Jan Engelhardt. All Rights Reserved."
X-Notice: "Duplication, redistribution and involvement of third parties is not permitted without prior written permission."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> >say? How do you know that you actually have any routes at all?
>> Yes, ni0 and ni1 are always there (renamed eth0/eth1), and especially lo.
>
>Hmm I just noticed that you're using a custom kernel.  Can you please
>try reproducing this under 2.6.12-rc4?

Seems fixed under 2.6.12-rc4.
Ok, it falls under someone else's responsibility then.


Jan Engelhardt
-- 
