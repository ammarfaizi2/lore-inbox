Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316728AbSHOLD2>; Thu, 15 Aug 2002 07:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316753AbSHOLD2>; Thu, 15 Aug 2002 07:03:28 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:33427 "EHLO
	gatekeeper.slim") by vger.kernel.org with ESMTP id <S316728AbSHOLD1>;
	Thu, 15 Aug 2002 07:03:27 -0400
Subject: sound choking with trident driver (SiS 7018)
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-2) 
Date: 15 Aug 2002 13:11:49 +0200
Message-Id: <1029409909.1121.17.camel@paragon.slim>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a laptop with a SiS 7018 soundchip. While playing music
the sound chokes every few seconds (2.4.19 kernel). I am not sure where
the problem lies. With the ALSA drivers under kernel 2.5 the problem is
not there.

Is there a newer driver for the SiS 7018 (trident.c). The current driver
in 2.4 is dated October 2001.


Greetings,

Jurgen




