Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283271AbRK2PMp>; Thu, 29 Nov 2001 10:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283270AbRK2PMf>; Thu, 29 Nov 2001 10:12:35 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:3592 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S283265AbRK2PM0>; Thu, 29 Nov 2001 10:12:26 -0500
Subject: Re: rpm builder of kernel image
To: hch@ns.caldera.de (Christoph Hellwig)
Date: Thu, 29 Nov 2001 15:21:00 +0000 (GMT)
Cc: maftoul@esrf.fr (Samuel Maftoul), linux-kernel@vger.kernel.org
In-Reply-To: <200111291358.fATDwSh32089@ns.caldera.de> from "Christoph Hellwig" at Nov 29, 2001 02:58:28 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E169Szk-0000JN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You might want to take a look at make-krpm [1], currently I only have
> support for Caldera and a default target that might work or not work
> for others.  I accept patches..

Or for Linux 2.4.13 or later just type

	make config
	make rpm
