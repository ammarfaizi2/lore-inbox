Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWHIMat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWHIMat (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 08:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbWHIMas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 08:30:48 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:10136 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750714AbWHIMas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 08:30:48 -0400
Subject: Re: Marvell PATA IDE Controller
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060809113650.GA2959@mail.muni.cz>
References: <20060809113650.GA2959@mail.muni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 09 Aug 2006 13:50:50 +0100
Message-Id: <1155127850.5729.164.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-08-09 am 13:36 +0200, ysgrifennodd Lukas Hejtmanek:
> Hello,
> 
> is there a chance to get working Marvell PATA IDE Controller?
> According to lspci it has 11ab:6101 ID.

If Marvell docs/hw access land on my desk then yes. If not then no.
Thats why we now have jmicron support 8)

Alan

