Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270221AbRHGOe2>; Tue, 7 Aug 2001 10:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270223AbRHGOeS>; Tue, 7 Aug 2001 10:34:18 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:38157 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270221AbRHGOeD>; Tue, 7 Aug 2001 10:34:03 -0400
Subject: Re: DRM Linux kernel merge (update) needed, soon.
To: Dieter.Nuetzel@hamburg.de (Dieter =?iso-8859-1?q?N=FCtzel?=)
Date: Tue, 7 Aug 2001 15:35:46 +0100 (BST)
Cc: dri-devel@lists.sourceforge.net (DRI-Devel),
        linux-kernel@vger.kernel.org (Linux Kernel List)
In-Reply-To: <20010807014029Z270029-28344+2126@vger.kernel.org> from "Dieter =?iso-8859-1?q?N=FCtzel?=" at Aug 07, 2001 03:40:25 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15U7xS-00030p-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the Linux kernel DRM stuff need a merge (update), soon.

The XFree DRM needs fixing first. Try running the current XFree 4.1 DRI with
slab poisoning enabled and its not pretty.

Alan
