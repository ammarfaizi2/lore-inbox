Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291626AbSBNNMT>; Thu, 14 Feb 2002 08:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291619AbSBNNMJ>; Thu, 14 Feb 2002 08:12:09 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:34322 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291621AbSBNNMH>; Thu, 14 Feb 2002 08:12:07 -0500
Subject: Re: 2.5.4, cs46xx snd, and virt_to_bus
To: p_gortmaker@yahoo.com (Paul Gortmaker)
Date: Thu, 14 Feb 2002 13:26:04 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <3C6B5B09.48AF3140@yahoo.com> from "Paul Gortmaker" at Feb 14, 2002 01:36:57 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16bLtk-0008RA-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Minor nit, but if we go that route, maybe make it request_isa_mem_region() 
> just to be consistent with all the other request_xxxx type functions ?

All the other bus functions start pci_ and isa_ 8)

