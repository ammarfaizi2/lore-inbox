Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261993AbUD1VBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbUD1VBA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 17:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbUD1T5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 15:57:42 -0400
Received: from mail.gmx.de ([213.165.64.20]:14564 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265032AbUD1SQX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 14:16:23 -0400
X-Authenticated: #20450766
Date: Wed, 28 Apr 2004 20:15:44 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: hda active and hdb sleep?
Message-ID: <Pine.LNX.4.44.0404282012480.810-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

As soon as I issue hdparm -Y /dev/hdb I get errors on hda and it doesn't
seem to be possible to have hdb in sleep and hfa active. In a book I've
read, that those power-states are purely per-device. Is the book wrong or
is it something different? It's a VIA ProSavage KM133 chipset.

Thanks
Guennadi
---
Guennadi Liakhovetski


