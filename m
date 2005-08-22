Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751384AbVHVWdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbVHVWdT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbVHVWdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:33:18 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:31370 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751412AbVHVWdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:33:16 -0400
Date: Mon, 22 Aug 2005 09:28:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: Andrew Morton <akpm@osdl.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] quirk_via_vt8237_bypass_apic_deassert
Message-ID: <20050822072851.GA19022@elte.hu>
References: <200508181047.34228.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508181047.34228.annabellesgarden@yahoo.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Karsten Wiese <annabellesgarden@yahoo.de> wrote:

> Hi Andrew,
> 
> This helps at least on Ingo's and my AMD64@K8T800
> and shouldn't bite anybody else.
> Please add to -mm for later inclusion into mainline.

> Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>

Tested-by: Ingo Molnar <mingo@elte.hu>

	Ingo
