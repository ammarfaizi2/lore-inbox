Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261770AbVEVIKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbVEVIKq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 04:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbVEVIKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 04:10:46 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:6569 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261770AbVEVIKl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 04:10:41 -0400
Date: Sun, 22 May 2005 10:10:29 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Herbert Xu <herbert@gondor.apana.org.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: route procfile problems
In-Reply-To: <E1DZlK1-0005Js-00@gondolin.me.apana.org.au>
Message-ID: <Pine.LNX.4.61.0505221009280.21187@yvahk01.tjqt.qr>
References: <E1DZlK1-0005Js-00@gondolin.me.apana.org.au>
X-Copyright: "Copyright (C) by Jan Engelhardt. All Rights Reserved."
X-Notice: "Duplication, redistribution and involvement of third parties is not permitted without prior written permission."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

>However, with that addition I've tried a number of shells including
>bash and they all work as expected.  So please do
>
>strace -f sh -c 'while read line; do echo $line; done < /proc/net/route'
>
>as that should give us the necessary clue.

http://linux01.org/~jengelh/sh.txt



Regards,
Jan Engelhardt
-- 
