Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266725AbRGLVvg>; Thu, 12 Jul 2001 17:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266750AbRGLVv0>; Thu, 12 Jul 2001 17:51:26 -0400
Received: from gene.pbi.nrc.ca ([204.83.147.150]:21269 "EHLO gene.pbi.nrc.ca")
	by vger.kernel.org with ESMTP id <S266725AbRGLVvM>;
	Thu, 12 Jul 2001 17:51:12 -0400
Date: Thu, 12 Jul 2001 15:47:58 -0600 (CST)
From: <ognen@gene.pbi.nrc.ca>
To: <linux-kernel@vger.kernel.org>
Subject: strange 2.4.x problems with dual machine
In-Reply-To: <20010709120243.A39@toy.ucw.cz>
Message-ID: <Pine.LNX.4.30.0107121544570.2802-100000@gene.pbi.nrc.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

machine is a dual Celeron (mendocino) with 256 M RAM, pretty standard. Ran
fine with 2.2.x, now when I switched to 2.4.2, 2.4.5 or 2.4.6 it freezes
on random (under X). Worked in text mode for a while and then printed out
a line "APIC error on CPU #0: 00(08)" and died...

Any ideas? I have booted the kernels both with and without "noapic" and
still the same...

Ognen

