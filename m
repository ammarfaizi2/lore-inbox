Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965985AbWKINX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965985AbWKINX0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 08:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965987AbWKINX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 08:23:26 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:9613 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965985AbWKINXZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 08:23:25 -0500
Subject: Re: IDE cs5530 hda: lost interrupt
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Saulo <slima@tse.gov.br>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <45532D7E.6050606@tse.gov.br>
References: <455254B8.4000704@tse.gov.br>
	 <1163022263.23956.100.camel@localhost.localdomain>
	 <45525EB0.1070907@tse.gov.br>
	 <1163023173.23956.111.camel@localhost.localdomain>
	 <45532D7E.6050606@tse.gov.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Thu, 09 Nov 2006 13:28:10 +0000
Message-Id: <1163078890.23956.147.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-11-09 am 10:30 -0300, ysgrifennodd Saulo:
> No it's not a PDA designed for Windows CE it´s a motherboard designed 
> for us like 386 compatible. According to motherboard´s designers INTR 
> are standard and Windows XP run too without any changes.

Have you tested this.. ? From the docs I don't see any obvious other
explanation.

