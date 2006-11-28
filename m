Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935784AbWK1KKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935784AbWK1KKA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 05:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935789AbWK1KJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 05:09:59 -0500
Received: from mpemail.mpe-garching.mpg.de ([130.183.137.110]:43238 "EHLO
	mpemail.mpe.mpg.de") by vger.kernel.org with ESMTP id S935784AbWK1KJ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 05:09:58 -0500
From: "Martin A. Fink" <fink@mpe.mpg.de>
Organization: MPE
To: Alan <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: SATA Performance with Intel ICH6
Date: Tue, 28 Nov 2006 11:09:47 +0100
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611281109.47438.fink@mpe.mpg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Alan,

You wrote
> The PIIX interface needs CPU intervention each command, so in practice
> about every 64K or so, and the CPU gets stalled waiting for the disk
> during the setup of each I/O. The newer kernels support AHCI which does
> not have this overhead, but it is only present on the newest intel
> controllers.

Can you tell me the name of these newest controllers? Is it ICH7 or 8 ?
What kernel versions? dmesg only shows ACPI and u/e/o hci_* host controller.
(kernel version is 2.6.8-24.25-smp). How can I switch to AHCI ?

Thank you very much,

Martin
