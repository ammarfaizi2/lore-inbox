Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261566AbUJaTF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbUJaTF5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 14:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbUJaTF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 14:05:57 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:18561 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261566AbUJaTFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 14:05:52 -0500
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org, pluto@pld-linux.org
X-Message-Flag: Warning: May contain useful information
References: <200410311541.i9VFf0ah023857@harpo.it.uu.se>
From: Roland Dreier <roland@topspin.com>
Date: Sun, 31 Oct 2004 11:05:51 -0800
In-Reply-To: <200410311541.i9VFf0ah023857@harpo.it.uu.se> (Mikael
 Pettersson's message of "Sun, 31 Oct 2004 16:41:00 +0100 (MET)")
Message-ID: <52wtx6vhbk.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: unit-at-a-time...
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 31 Oct 2004 19:05:51.0854 (UTC) FILETIME=[A3D260E0:01C4BF7C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

By the way, does anyone know if Richard Henderson's work in gcc 4.0
(http://gcc.gnu.org/ml/gcc-patches/2004-09/msg00333.html) on laying
out stack variables means that -funit-at-a-time will be safe to use
again for the kernel?

Thanks,
  Roland
