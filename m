Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269359AbUICPdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269359AbUICPdP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 11:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269480AbUICPRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 11:17:31 -0400
Received: from host50.200-117-131.telecom.net.ar ([200.117.131.50]:44520 "EHLO
	smtp.bensa.ar") by vger.kernel.org with ESMTP id S269153AbUICPPM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 11:15:12 -0400
From: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm3
Date: Fri, 3 Sep 2004 12:15:05 -0300
User-Agent: KMail/1.7
Cc: Andrew Morton <akpm@osdl.org>
References: <20040903014811.6247d47d.akpm@osdl.org>
In-Reply-To: <20040903014811.6247d47d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409031215.06062.norberto+linux-kernel@bensa.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6
>.9-rc1-mm3/

Same behavior than -mm2, KDE doesn't start: hangs at kbuildsycoca or kcminit 
with status D. No crash. No oops.

I've tried with acpi=noirq and acpi=off, but neither fixed the problem. I'm 
back to 2.6.9-rc1-mm1 for now. If you have any idea, please let me know.

Thanks,
Norberto
