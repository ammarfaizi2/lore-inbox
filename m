Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267333AbUI0USj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267333AbUI0USj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 16:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267335AbUI0USa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 16:18:30 -0400
Received: from scanner2.mail.elte.hu ([157.181.151.9]:479 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267323AbUI0URm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 16:17:42 -0400
Date: Mon, 27 Sep 2004 22:19:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Gene Heskett <gene.heskett@verizon.net>,
       Matt Heler <lkml@lpbproductions.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc2-mm4
Message-ID: <20040927201928.GB19257@elte.hu>
References: <20040926181021.2e1b3fe4.akpm@osdl.org> <200409270053.22911.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409270053.22911.gene.heskett@verizon.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Gene Heskett <gene.heskett@verizon.net> wrote:

> The bootup hangs, from dmesg after reboot to 2.6.9-rc2-mm3:
> 
> Checking 'hlt' instruction... OK.
> -----
> 2.6.9-rc2-mm4 hangs here, and never gets to the next line
> -----
> NET: Registered protocol family 16
> 
> So I assume something in the next line hangs it. Sysrq-t has no
> repsonse, must use the hardware reset button.

could you send me your .config?

	Ingo
