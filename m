Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265601AbSJSNqb>; Sat, 19 Oct 2002 09:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265602AbSJSNqb>; Sat, 19 Oct 2002 09:46:31 -0400
Received: from mailgate5.cinetic.de ([217.72.192.165]:6815 "EHLO
	mailgate5.cinetic.de") by vger.kernel.org with ESMTP
	id <S265601AbSJSNqb>; Sat, 19 Oct 2002 09:46:31 -0400
Date: Sat, 19 Oct 2002 15:52:28 +0200
Message-Id: <200210191352.g9JDqSX08014@mailgate5.cinetic.de>
MIME-Version: 1.0
Organization: http://freemail.web.de/
From: Michael Kiefer <Michael-Kiefer@web.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel Panic 2.4.19 with Segate 80GB HDD
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the same problem:
ST380020ACE produces a kernel panic when I try to pass the disk geometry data manually "hda=noprobe hda=XXXXX/YYY/ZZ hdb=none" to the kernels 2.4.18 _and_ 2.4.19. I have to do it this way as autodetection fails. I use a NMC-7VAX (Via KX133) Mainboard / Athlon 800


________________________________________________________________
Keine verlorenen Lotto-Quittungen, keine vergessenen Gewinne mehr! 
Beim WEB.DE Lottoservice: http://tippen2.web.de/?x=13


