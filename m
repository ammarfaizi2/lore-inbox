Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131233AbRCWQea>; Fri, 23 Mar 2001 11:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131236AbRCWQeU>; Fri, 23 Mar 2001 11:34:20 -0500
Received: from gwyn.tux.org ([207.96.122.8]:14251 "EHLO gwyn.tux.org")
	by vger.kernel.org with ESMTP id <S131233AbRCWQeI>;
	Fri, 23 Mar 2001 11:34:08 -0500
Date: Fri, 23 Mar 2001 11:33:27 -0500 (EST)
From: Joel Gallun <joel@tux.org>
To: <linux-kernel@vger.kernel.org>
Subject: raw access and qlogic isp device driver?
Message-ID: <Pine.LNX.4.30.0103231129060.6117-100000@gwyn.tux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm trying to use Stephen Tweedie's raw device support to access disks
attached to a Qlogic ISP 1040/B controller and kernel oopses.

Has anyone used the raw device with qlogicisp driver? Does anyone have any
interest in looking at this?

Thanks!

--
Joel Gallun                                         joel@tux.org
Open system and Internet consulting     http://www.tux.org/~joel

