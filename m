Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbWGGTvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbWGGTvv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 15:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWGGTvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 15:51:51 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48361 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932295AbWGGTvu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 15:51:50 -0400
Subject: Re: Pata via ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Gregoire Favre <gregoire.favre@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060707180751.GA8891@gmail.com>
References: <20060707180751.GA8891@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 07 Jul 2006 21:09:22 +0100
Message-Id: <1152302962.20883.65.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-07-07 am 20:07 +0200, ysgrifennodd Gregoire Favre:
> I have fetched libata-dev and even there, there is no pata_via...
> 
> Any reason for this ?

git checkout pata-drivers

The base branch if I remember rightly is Linus tree, because of the way
Jeff works

