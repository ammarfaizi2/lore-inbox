Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266127AbUFEBRo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266127AbUFEBRo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 21:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266129AbUFEBRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 21:17:44 -0400
Received: from palrel12.hp.com ([156.153.255.237]:65414 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S266128AbUFEBRX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 21:17:23 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16577.7968.593972.354254@napali.hpl.hp.com>
Date: Fri, 4 Jun 2004 18:17:20 -0700
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: davidm@hpl.hp.com, David Mosberger <davidm@napali.hpl.hp.com>,
       Michael_E_Brown@dell.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: EFI-support for SMBIOS driver
In-Reply-To: <200406050309.36397.bzolnier@elka.pw.edu.pl>
References: <16577.6469.833064.763671@napali.hpl.hp.com>
	<200406050309.36397.bzolnier@elka.pw.edu.pl>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sat, 5 Jun 2004 03:09:36 +0200, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> said:

  Bartlomiej> It seems SMBIOS driver is gone.

  Bartlomiej> http://linus.bkbits.net:8080/linux-2.5/cset@40b6702axansvQIxOVjTSIp7_DVoHA

Man, talk about going in circles!

If folks are serious about discouraging /dev/mem, then the SMBIOS
driver makes tons of sense.

	--david
