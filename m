Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266839AbTATUIg>; Mon, 20 Jan 2003 15:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266840AbTATUIf>; Mon, 20 Jan 2003 15:08:35 -0500
Received: from quechua.inka.de ([193.197.184.2]:37779 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S266839AbTATUIe>;
	Mon, 20 Jan 2003 15:08:34 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: ANN: LKMB (Linux Kernel Module Builder) version 0.1.16
References: <25160.1042809144@passion.cambridge.redhat.com> <Pine.LNX.4.33L2.0301171857230.25073-100000@vipe.technion.ac.il> <E18a1aZ-0006mL-00@bigred.inka.de> <20030119001256.GA11575@compsoc.man.ac.uk> <E18aEyl-0006O0-00@bigred.inka.de> <1042981591.1479.5.camel@laptop.fenrus.com>
Organization: private Linux site, southern Germany
Date: Mon, 20 Jan 2003 21:16:21 +0100
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E18aiLF-00034c-00@bigred.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes it breaks if you move around your source after doing make
> modules_install. Yes it breaks if you don't have the tree at all. But
> both situations are "invalid" wrt the decree, and need a fixed symlink.

This means the decree also rules out compiling a kernel for one box on
another?

Olaf

