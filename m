Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264748AbTAWAOQ>; Wed, 22 Jan 2003 19:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264749AbTAWAOQ>; Wed, 22 Jan 2003 19:14:16 -0500
Received: from echo.sound.net ([205.242.192.21]:43509 "HELO echo.sound.net")
	by vger.kernel.org with SMTP id <S264748AbTAWAOQ>;
	Wed, 22 Jan 2003 19:14:16 -0500
Date: Wed, 22 Jan 2003 18:20:23 -0600 (CST)
From: Hal Duston <hald@sound.net>
To: linux-kernel@vger.kernel.org
Subject: Re: ANN: LKMB (Linux Kernel Module Builder) version 0.1.16
Message-ID: <Pine.GSO.4.10.10301221816580.22843-100000@sound.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use "INSTALL_MOD_PATH=put/the/modules/here/instead/of/lib/modules" in my
.profile or whatever in order to drop the modules into another directory
at "make modules_install" time.  Is this one of the things folks are
talking about?

Hal Duston

