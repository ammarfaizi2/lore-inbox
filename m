Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbTI3JNl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 05:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbTI3JNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 05:13:41 -0400
Received: from cc78409-a.hnglo1.ov.home.nl ([212.120.97.185]:40167 "EHLO
	dexter.hensema.net") by vger.kernel.org with ESMTP id S261227AbTI3JNk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 05:13:40 -0400
From: Erik Hensema <erik@hensema.net>
Subject: Dependency bug? Alsa es1370 needs joystick support
Date: Tue, 30 Sep 2003 09:13:38 +0000 (UTC)
Message-ID: <slrnbniia2.p62.erik@bender.home.hensema.net>
Reply-To: erik@hensema.net
User-Agent: slrn/0.9.7.4 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I lost sound support after the upgrade from -test4 to -test6; I've been
told on IRC that this could be due to a dependency of the sounddriver on
joystick support. This indeed seems to be the case.

I'm using the (Creative) Ensoniq AudioPCI 1370 driver.

-- 
Erik Hensema <erik@hensema.net>
