Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271328AbUJVMyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271328AbUJVMyr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 08:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269105AbUJVMxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 08:53:39 -0400
Received: from vsmtp14.tin.it ([212.216.176.118]:54720 "EHLO vsmtp14.tin.it")
	by vger.kernel.org with ESMTP id S271276AbUJVMwF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 08:52:05 -0400
Date: Fri, 22 Oct 2004 15:00:48 +0200
From: Luca Risolia <luca.risolia@studio.unibo.it>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, luc@saillard.org
Subject: Re: Linux 2.6.9-ac3
Message-Id: <20041022150048.0d26fdeb.luca.risolia@studio.unibo.it>
In-Reply-To: <1098443375.19459.4.camel@localhost.localdomain>
References: <20041022101335.6dcf247a.luca.risolia@studio.unibo.it>
	<1098443375.19459.4.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Oct 2004 12:09:37 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Gwe, 2004-10-22 at 09:13, Luca Risolia wrote:
> > > o       Restore PWC driver                              (Luc Saillard)
> > 
> > This driver does decompression in kernel space, which is not
> > allowed. That part has to be removed from the driver before
> > asking for the inclusion in the mainline kernel.
> 
> I agree but lets get there a step at a time.

This is a step backward.
