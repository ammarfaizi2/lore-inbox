Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270824AbTG1VWR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 17:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271047AbTG1VWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 17:22:17 -0400
Received: from pat.uio.no ([129.240.130.16]:1460 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S270824AbTG1VWO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 17:22:14 -0400
To: "Kathy Frazier" <kfrazier@mdc-dayton.com>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Mike Dresser" <mdresser_l@windsormachine.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: DMA not supported with Intel ICH4 I/O controller?
References: <PMEMILJKPKGMMELCJCIGCEJCCDAA.kfrazier@mdc-dayton.com>
From: Terje Kvernes <terjekv@math.uio.no>
Organization: The friends of mr. Tux
X-URL: http://terje.kvernes.no/
Date: Mon, 28 Jul 2003 23:21:49 +0200
In-Reply-To: <PMEMILJKPKGMMELCJCIGCEJCCDAA.kfrazier@mdc-dayton.com> (Kathy
 Frazier's message of "Mon, 28 Jul 2003 17:02:14 -0500")
Message-ID: <wxx1xwas5xu.fsf@nommo.uio.no>
User-Agent: Gnus/5.1001 (Gnus v5.10.1) Emacs/21.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Kathy Frazier" <kfrazier@mdc-dayton.com> writes:

> Thanks for your reply!  Later?  Could you be more specific?  What
> version?  

  as far as I can tell, 2.4.21 doesn't support it, but 2.4.22-pre8
  mentions the chipset in drivers/ide/pci/piix.h.  try downloading
  2.4.21 and patch it up to 2.4.22-pre8 and see if it works.  :-)

> Management is chomping at the bit here.  

  you have my sympathy, for what it's worth.

  [ ... ]

-- 
Terje
