Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbWEWSmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbWEWSmm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 14:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbWEWSmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 14:42:42 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:2964 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932254AbWEWSml
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 14:42:41 -0400
Subject: Re: Compact Flash Serial ATA patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell McConnachie <russell.mcconnachie@guest-tek.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1148379397.1182.4.camel@gt-alphapbx2>
References: <1148379397.1182.4.camel@gt-alphapbx2>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 23 May 2006 19:56:30 +0100
Message-Id: <1148410590.25255.115.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-05-23 at 04:16 -0600, Russell McConnachie wrote:
> I am not exactly a programmer, I'm sure this can be written much better
> but for anyone who may run into a similar problem with compact flash.

Some CF adapters do not include all the neccessary pins for DMA because
they were designed to be cheap before the idea of CF using DMA seemed
realistic.

Alan

