Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265025AbTFRMcK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 08:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265060AbTFRMcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 08:32:09 -0400
Received: from mail0.ewetel.de ([212.6.122.12]:36010 "EHLO mail0.ewetel.de")
	by vger.kernel.org with ESMTP id S265025AbTFRMcI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 08:32:08 -0400
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
In-Reply-To: <20030618111010$154f@gated-at.bofh.it>
References: <20030507203025$6f60@gated-at.bofh.it> <20030509005011$6cee@gated-at.bofh.it> <20030509101012$732a@gated-at.bofh.it> <20030509122007$758f@gated-at.bofh.it> <20030509131009$00f3@gated-at.bofh.it> <20030611045008$03cf@gated-at.bofh.it> <20030611203031$12de@gated-at.bofh.it> <20030611211012$34cf@gated-at.bofh.it> <20030613095017$1680@gated-at.bofh.it> <20030617210022$3e37@gated-at.bofh.it> <20030618111010$154f@gated-at.bofh.it>
Date: Wed, 18 Jun 2003 14:46:02 +0200
Message-Id: <E19ScKA-0000Pt-00@neptune.local>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski wrote in linux-kernel:

> around 70-100 GB of data is transferred to a nfs-server with rc8 onto a RAID5
> on 3ware-controller.
> The data is then copied via tar onto a SDLT drive connected to an aic
> controller.
> Afterwards the data is verified by tar.

Have you tried with a different SCSI controller to rule out bugs in st.c?

-- 
Ciao,
Pascal
