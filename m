Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276839AbRJKURA>; Thu, 11 Oct 2001 16:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276842AbRJKUQu>; Thu, 11 Oct 2001 16:16:50 -0400
Received: from anime.net ([63.172.78.150]:7 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S276839AbRJKUQn>;
	Thu, 11 Oct 2001 16:16:43 -0400
Date: Thu, 11 Oct 2001 13:16:51 -0700 (PDT)
From: Dan Hollis <goemon@anime.net>
To: Ion Badulescu <ionut@cs.columbia.edu>
cc: "Matthew S. Hallacy" <poptix@techmonkeys.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: eepro100.c bug on 10Mbit half duplex (kernels 2.4.5 / 2.4.10 /
 2.4.11pre6 / 2.4.11 / 2.4.10ac11)
In-Reply-To: <200110112008.f9BK8dP20700@buggy.badula.org>
Message-ID: <Pine.LNX.4.30.0110111316150.355-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Oct 2001, Ion Badulescu wrote:
> Umm, no, that's actually an 82558 rev B. pci.ids should be updated to
> have "Intel Corporation 8255[7-9]" for this id, because Intel can't make
> up their minds to change the PCI id when they release a new product.
> rev 1-3 are 82557, rev 4-5 are 82558, rev 6-8 are 82559.

lspci should be changed to take in account rev numbers...

-Dan
-- 
[-] Omae no subete no kichi wa ore no mono da. [-]

