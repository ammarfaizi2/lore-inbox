Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131324AbRDBWDU>; Mon, 2 Apr 2001 18:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131369AbRDBWDL>; Mon, 2 Apr 2001 18:03:11 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:29201 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131324AbRDBWC7>; Mon, 2 Apr 2001 18:02:59 -0400
Subject: Re: Oracle 8I & Kernel 2.4.3 : Sane ?
To: Yann.Dupont@IPv6.univ-nantes.fr (Yann Dupont)
Date: Mon, 2 Apr 2001 23:04:50 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <986213560.24497.2.camel@olive> from "Yann Dupont" at Apr 02, 2001 02:12:40 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14kCRR-0006ob-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I noticed that 2.4.3 contains some fixs for shared memory -
> So the final question IS :
> 
> Is oracle 8.1.5 + Kernel 2.4.3 a sane combination ?

Probably not yet but getting closer.

> In general is oracle + Kernel 2.4 working ? 

Ditto.

The shm and rawio fixes are very recent

