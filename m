Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263768AbTCUV3V>; Fri, 21 Mar 2003 16:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263762AbTCUV21>; Fri, 21 Mar 2003 16:28:27 -0500
Received: from main.gmane.org ([80.91.224.249]:22500 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S262900AbTCUV1y>;
	Fri, 21 Mar 2003 16:27:54 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jason Lunz <lunz@falooley.org>
Subject: Re: [BK PATCH] net driver merges
Date: Fri, 21 Mar 2003 21:38:45 +0000 (UTC)
Organization: PBR Streetgang
Message-ID: <slrnb7n1jd.inc.lunz@stoli.localnet>
References: <3E7AA337.5000402@pobox.com>
X-Complaints-To: usenet@main.gmane.org
User-Agent: slrn/0.9.7.4 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jgarzik@pobox.com said:
> Linus, please do a
> 	bk pull bk://kernel.bkbits.net/jgarzik/net-drivers-2.5
> This will update the following files:

2.5 still has an uninitialized spinlock in the eepro100 driver. Marcelo
already merged the fix in 2.4 bk:

http://www.kernel.org/pub/linux/kernel/v2.4/testing/cset/cset-1.1073.txt

Jason

