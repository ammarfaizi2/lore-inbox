Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318718AbSG0Iz3>; Sat, 27 Jul 2002 04:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318719AbSG0Iz3>; Sat, 27 Jul 2002 04:55:29 -0400
Received: from uucp.nl.uu.net ([193.79.237.146]:11492 "EHLO uucp.nl.uu.net")
	by vger.kernel.org with ESMTP id <S318718AbSG0Iz3>;
	Sat, 27 Jul 2002 04:55:29 -0400
Date: Sat, 27 Jul 2002 10:56:31 +0200 (CEST)
From: kees <kees@schoen.nl>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.19.rc3{8139too as module}
Message-ID: <Pine.LNX.4.33.0207271054120.8193-100000@schoen3.schoen.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I tried to use 8139too as module, but that failed. 4 mii_...... like
mii_link_ok() could not be resolved (at load time).  As a compiled in
driver it works ok.

Kees

