Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261796AbVEVMbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbVEVMbF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 08:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbVEVMbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 08:31:05 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:46011 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261796AbVEVMbA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 08:31:00 -0400
Date: Sun, 22 May 2005 14:30:47 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Herbert Xu <herbert@gondor.apana.org.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: route procfile problems
In-Reply-To: <20050522081918.GA20588@gondor.apana.org.au>
Message-ID: <Pine.LNX.4.61.0505221429570.9671@yvahk01.tjqt.qr>
References: <E1DZlK1-0005Js-00@gondolin.me.apana.org.au>
 <Pine.LNX.4.61.0505221009280.21187@yvahk01.tjqt.qr> <20050522081918.GA20588@gondor.apana.org.au>
X-Copyright: "Copyright (C) by Jan Engelhardt. All Rights Reserved."
X-Notice: "Duplication, redistribution and involvement of third parties is not permitted without prior written permission."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> http://linux01.org/~jengelh/sh.txt
>strace -f cat /proc/net/route
http://linux01.org/~jengelh/cat.txt

>say? How do you know that you actually have any routes at all?

Yes, ni0 and ni1 are always there (renamed eth0/eth1), and especially lo.



Jan Engelhardt
-- 
