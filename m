Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbULTPMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbULTPMK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 10:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbULTPMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 10:12:10 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:14829 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261520AbULTPJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 10:09:42 -0500
Subject: Re: [patch 2.6.10-rc3 1/4] agpgart: allow multiple backends to be
	initialized
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: werner@sgi.com
Cc: davej@codemonkey.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       DRI Devel <dri-devel@lists.sourceforge.net>
In-Reply-To: <200412171255.59390.werner@sgi.com>
References: <200412171255.59390.werner@sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1103551539.29968.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 20 Dec 2004 14:05:40 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-12-17 at 20:55, Mike Werner wrote:
> [2/4] Run Lindent on generic.c

Please don't mix reformatting with oither submissions, especially as
Dave Jones is parallel working on and submitting patches for the various
cache/tlb flush violations in the current code that will overlap such a
reformatting.

