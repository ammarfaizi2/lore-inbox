Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266233AbTADGEI>; Sat, 4 Jan 2003 01:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266210AbTADGEI>; Sat, 4 Jan 2003 01:04:08 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:56311 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S266233AbTADGEH>;
	Sat, 4 Jan 2003 01:04:07 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15894.31574.165631.578519@napali.hpl.hp.com>
Date: Fri, 3 Jan 2003 22:12:38 -0800
To: "Andrey Panin" <pazke@orbita1.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] irq handling code consolidation (common part)
In-Reply-To: <20030104050356.GA10477@pazke>
References: <20021224060331.GA1090@pazke>
	<15892.34096.565694.402521@napali.hpl.hp.com>
	<20030104050356.GA10477@pazke>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sat, 4 Jan 2003 08:03:56 +0300, "Andrey Panin" <pazke@orbita1.ru> said:

  Andrey> BTW: what is the state of ia64 port in stock 2.5 ?  It looks
  Andrey> horribly borken :(

You need the matching patch from
ftp://ftp.kernel.org/pub/linux/kernel/ports/ia64/v2.5/

	--david
