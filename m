Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271252AbUJVMM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271252AbUJVMM1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 08:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271253AbUJVMM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 08:12:27 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:17887 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S271252AbUJVMM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 08:12:26 -0400
Subject: Re: Linux 2.6.9-ac3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Luca Risolia <luca.risolia@studio.unibo.it>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Luc Saillard <luc@saillard.org>
In-Reply-To: <20041022101335.6dcf247a.luca.risolia@studio.unibo.it>
References: <20041022101335.6dcf247a.luca.risolia@studio.unibo.it>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098443375.19459.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 22 Oct 2004 12:09:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-10-22 at 09:13, Luca Risolia wrote:
> > o       Restore PWC driver                              (Luc Saillard)
> 
> This driver does decompression in kernel space, which is not
> allowed. That part has to be removed from the driver before
> asking for the inclusion in the mainline kernel.

I agree but lets get there a step at a time.
