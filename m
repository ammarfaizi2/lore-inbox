Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266002AbRF1QB3>; Thu, 28 Jun 2001 12:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266005AbRF1QBT>; Thu, 28 Jun 2001 12:01:19 -0400
Received: from domino.polinet.hu ([195.70.35.102]:41488 "EHLO
	domino.polinet.hu") by vger.kernel.org with ESMTP
	id <S266002AbRF1QBI>; Thu, 28 Jun 2001 12:01:08 -0400
To: Keith Owens <kaos@ocs.com.au>
Subject: Re: Error while making 2.4.5 bzImage with CONFIG_MPENTIUMIII=y
Message-ID: <993744294.3b3b55a63540c@mail.holanyi.hu>
Date: Thu, 28 Jun 2001 18:04:54 +0200 (CEST)
From: Janos Holanyi <csani@lme.linux.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <7570.993736352@ocs3.ocs-net>
In-Reply-To: <7570.993736352@ocs3.ocs-net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.3
X-Originating-IP: 194.176.224.33
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you and Alan Cox for replying and helping.
Would it be a bad idea to incorporate the relevant part(s) of that FAQ into
(under) the kernel Documentation tree?
Would it be possible to have 'make' catch the error(s) causing an exit during
kernel compilation and display a message pointing to that file?
Such a feature would have made me feel less st*pid now ;)

Regs,

Csan

Quoting Keith Owens <kaos@ocs.com.au>:

> >time make dep clean bzImage modules moduels_install 2>&1 | tee
> bzImage.log
> 
> Please read the FAQ at  http://www.tux.org/lkml/, in particular s8-8.
> 
> 
