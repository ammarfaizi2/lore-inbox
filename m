Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262478AbVAJVAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262478AbVAJVAq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 16:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262500AbVAJVAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 16:00:35 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:54733 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262478AbVAJU7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 15:59:41 -0500
Subject: Re: starting with 2.7
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@muc.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m1fz196o39.fsf@muc.de>
References: <1697129508.20050102210332@dns.toxicfilms.tv>
	 <41DD9968.7070004@comcast.net>
	 <1105045853.17176.273.camel@localhost.localdomain>
	 <1105115671.12371.38.camel@DreamGate> <41DEC5F1.9070205@comcast.net>
	 <1105237910.11255.92.camel@DreamGate> <41E0A032.5050106@comcast.net>
	 <1105278618.12054.37.camel@localhost.localdomain>
	 <41E1CCB7.4030302@comcast.net> <21d7e99705010917281c6634b8@mail.gmail.com>
	 <1105361337.12054.66.camel@localhost.localdomain>  <m1fz196o39.fsf@muc.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105386921.12004.126.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 10 Jan 2005 19:55:22 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-01-10 at 20:11, Andi Kleen wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> I haven't seen a real request from someone who requires 1GB, but needs
> to use more than 96MB (16MB GFP_DMA + 64-128MB softiommu/amd iommu memory) 

Some bm4400 users report this problem.

