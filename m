Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160995AbWJRO0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160995AbWJRO0V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 10:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161029AbWJRO0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 10:26:21 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:53141 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S1160995AbWJRO0U convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 10:26:20 -0400
X-AntiVirus: PTMail-AV 0.3-0.88.4
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
To: Dyson <Linux@adelphia.net>
Subject: Re: Still broken sata (VIA) on Asus A8V (kernel 2.6.14+) with irqbalance
Date: Wed, 18 Oct 2006 15:26:03 +0100
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org
References: <4534F41A.1030504@Adelphia.net>
In-Reply-To: <4534F41A.1030504@Adelphia.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610181526.05336.sergio@sergiomb.no-ip.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 October 2006 16:17, Dyson wrote:
> I put in the patch mentioned below to get rid of the VIA IRQ fixup for a
> VIA K8T800 SMP machine and the computer hasn't froze yet after 19 hours

Ok many thanks for your positive report :) 
Now the latest patch is http://lkml.org/lkml/diff/2006/9/7/235/1 from 
http://lkml.org/lkml/2006/9/7/235
which is in -mm kernels,
and I also need the patch to have more stability , but don't resolve all 
problems 

best regards, 
-- 
Sérgio M. B.
