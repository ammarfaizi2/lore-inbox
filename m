Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbUKVIdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbUKVIdV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 03:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbUKVIdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 03:33:21 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:52958 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261984AbUKVIdS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 03:33:18 -0500
Date: Mon, 22 Nov 2004 09:33:14 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Gene Heskett <gene.heskett@verizon.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Stupid question
In-Reply-To: <200411212045.51606.gene.heskett@verizon.net>
Message-ID: <Pine.LNX.4.53.0411220932370.12534@yvahk01.tjqt.qr>
References: <200411212045.51606.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Greetings;
>
>Silly Q of the day probably, but what do I set in a Makefile for the
>-march=option for building on a 233 mhz Pentium 2?

Now that's really stupid, but here's the answer:

You run `make menuconfig` (or whichever you like) and choose Processor Type
"Pentium II".


Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
