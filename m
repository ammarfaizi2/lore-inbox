Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271890AbRH1TiI>; Tue, 28 Aug 2001 15:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271891AbRH1Th6>; Tue, 28 Aug 2001 15:37:58 -0400
Received: from iscserv1.astro.cornell.edu ([132.236.6.91]:29091 "EHLO
	isc.astro.cornell.edu") by vger.kernel.org with ESMTP
	id <S271890AbRH1Thp>; Tue, 28 Aug 2001 15:37:45 -0400
Date: Tue, 28 Aug 2001 15:38:02 -0400
From: "Donald J. Barry" <don@iscserv1.astro.cornell.edu>
Message-Id: <200108281938.f7SJc2509239@isc.astro.cornell.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.9 breaks ymfpci on VAIO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


To add another datapoint to Martin Mueller's observation, the 
 > Aug 21 15:01:33 cicero kernel: ymfpci_codec_ready: codec 0 is not ready [0xffff]

codec frozen problem after suspend/restore is also broken in 2.4.9-pre4.  
Ergo, it's in the other three prepatches after 2.4.8.

It's also still broken in 2.4.10-pre1.

Don Barry
