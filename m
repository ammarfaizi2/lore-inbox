Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310917AbSCSX7h>; Tue, 19 Mar 2002 18:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310920AbSCSX71>; Tue, 19 Mar 2002 18:59:27 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:55058 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310917AbSCSX7N>; Tue, 19 Mar 2002 18:59:13 -0500
Subject: Re: Linux 2.4.19pre3-ac2
To: rddunlap@osdl.org (Randy.Dunlap)
Date: Wed, 20 Mar 2002 00:14:45 +0000 (GMT)
Cc: bunk@fs.tum.de (Adrian Bunk), davej@suse.de,
        alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L2.0203191552030.8339-100000@dragon.pdx.osdl.net> from "Randy.Dunlap" at Mar 19, 2002 03:56:36 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16nTkb-0000kc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> can you add "kernel/configs.c" to your "dontdiff" list?

Will do

> Or is there another way that I should handle this generated file?

Thats fine - a large "Automatically generated" banner never hurts
