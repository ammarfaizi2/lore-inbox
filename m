Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133004AbRDRE0n>; Wed, 18 Apr 2001 00:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133005AbRDRE0d>; Wed, 18 Apr 2001 00:26:33 -0400
Received: from mx5.sac.fedex.com ([199.81.194.37]:6665 "EHLO mx5.sac.fedex.com")
	by vger.kernel.org with ESMTP id <S133004AbRDRE0Q>;
	Wed, 18 Apr 2001 00:26:16 -0400
Date: Wed, 18 Apr 2001 12:26:34 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: <root@boston.corp.fedex.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Jeff Chua <jchua@fedex.com>
Subject: 2.4.4-pre4 nfsd.o unresolved symbol
Message-ID: <Pine.LNX.4.33.0104181224060.7126-100000@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I compiled 2.4.4-pre4 and use nfsd as a module. Got the following error:

depmod: *** Unresolved symbols in /lib/modules/2.4.4-pre4/kernel/fs/nfsd/nfsd.o
depmod:         nfsd_linkage_Rb56858ea


Didn't have such problem on 2.4.4-pre3.


Jeff
[ jchua@fedex.com ]

