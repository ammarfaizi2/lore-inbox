Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261931AbUEFM4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbUEFM4Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 08:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbUEFM4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 08:56:16 -0400
Received: from host199.200-117-131.telecom.net.ar ([200.117.131.199]:4071 "EHLO
	smtp.bensa.ar") by vger.kernel.org with ESMTP id S261931AbUEFMz7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 08:55:59 -0400
From: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK)
Date: Thu, 6 May 2004 09:55:57 -0300
User-Agent: KMail/1.6.2
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
References: <200405051312.30626.dominik.karall@gmx.net> <c7bin8$fg7$1@gatekeeper.tmr.com> <200405060104.55340.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200405060104.55340.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405060955.57856.norberto+linux-kernel@bensa.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> Making 4kb stacks default in -mm is very good idea so it will get necessary
> testing and fixing before being integrated into mainline.

Then let us test with _AND_ without 4KSTACKS.

I love the -mm three, but I use a nvidia GFX card too. Making 4KSTACkS 
permanent excludes me from more testing.

Best regards,
Norberto
