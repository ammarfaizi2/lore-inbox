Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269017AbUJENDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269017AbUJENDm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 09:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269014AbUJENDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 09:03:42 -0400
Received: from [213.146.154.40] ([213.146.154.40]:50352 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S269017AbUJENDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 09:03:31 -0400
Subject: Re: [PATCH 2.6] pci-hplj.c: replace pci_find_device with
	pci_get_device
From: David Woodhouse <dwmw2@infradead.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Hanna Linder <hannal@us.ibm.com>, linux-kernel@vger.kernel.org,
       kernel-janitors@lists.osdl.org, greg@kroah.com
In-Reply-To: <20041004214107.GA2160@linux-mips.org>
References: <281940000.1096925207@w-hlinder.beaverton.ibm.com>
	 <20041004214107.GA2160@linux-mips.org>
Content-Type: text/plain
Message-Id: <1096981395.30942.859.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Tue, 05 Oct 2004 14:03:16 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-04 at 23:41 +0200, Ralf Baechle wrote:
> Except that piece of code isn't for an RM[23]00 but a HP Laserjet (yes,
> that paper eating thing ;-) and hasn't seen any update or feedback from
> the original submitters since the original submission, so the entire HPLJ
> code is a candidate for removal ...

Any idea precisely what model, and how to get it installed? 
eBay calls... :)

-- 
dwmw2

