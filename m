Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130426AbRCGHX7>; Wed, 7 Mar 2001 02:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130428AbRCGHXt>; Wed, 7 Mar 2001 02:23:49 -0500
Received: from mail.mojomofo.com ([208.248.233.19]:43535 "EHLO mojomofo.com")
	by vger.kernel.org with ESMTP id <S130425AbRCGHXh>;
	Wed, 7 Mar 2001 02:23:37 -0500
Message-ID: <032e01c0a6d7$645ba140$0300a8c0@methusela>
From: "Aaron Tiensivu" <mojomofo@mojomofo.com>
To: "Linus Torvalds" <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <3AA5CA13.8C19FC7E@neuronet.pitt.edu> <200103070546.f275keO22502@aslan.scsiguy.com> <984jf1$1hj$1@penguin.transmeta.com>
Subject: Re: Kernel 2.4.3 and new aic7xxx
Date: Wed, 7 Mar 2001 02:22:38 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I suspect it's easier to just make the PCI layer call the probe function
> in that order, instead of working around it in your driver. Jeff?

Would 'pci=reverse' do the trick already?


