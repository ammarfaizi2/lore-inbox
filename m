Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbTE2AQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 20:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbTE2AQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 20:16:28 -0400
Received: from kaneda.boo.net ([216.200.67.189]:40601 "EHLO kaneda.boo.net")
	by vger.kernel.org with ESMTP id S261754AbTE2AQ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 20:16:28 -0400
Message-Id: <5.2.1.1.2.20030528203353.02367ec0@boo.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Wed, 28 May 2003 20:35:48 -0400
To: linux-kernel@vger.kernel.org
From: Jason Papadopoulos <jasonp@boo.net>
Subject: Re: Linux 2.4.21-rc3 : IDE pb on Alpha
In-Reply-To: <3ED42909.9040909@pobox.com>
References: <5.2.1.1.2.20030527211552.00a47190@boo.net>
 <20030527123152.GA24849@alpha.home.local>
 <5.2.1.1.2.20030526232835.00a468e0@boo.net>
 <20030527045302.GA545@alpha.home.local>
 <20030527134017.B3408@jurassic.park.msu.ru>
 <20030527123152.GA24849@alpha.home.local>
 <5.2.1.1.2.20030527211552.00a47190@boo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:12 PM 5/27/03 -0400, Jeff Garzik wrote:
 >
 >FWIW, udma2 is the best you can do without accurate cable detection and
 >an 80-conductor cable.
 >

Well, even with a drive capable of ATA66, an 80-pin cable, and a kernel
configured to force assumption of higher UDMA modes, the best I've ever
done with this stupid ALI controller is udma2. I think it's deliberately
crippled.

jasonp

