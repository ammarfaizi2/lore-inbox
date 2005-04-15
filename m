Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261968AbVDOUqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbVDOUqv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 16:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbVDOUqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 16:46:51 -0400
Received: from [81.2.110.250] ([81.2.110.250]:13261 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261968AbVDOUql (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 16:46:41 -0400
Subject: Re: Adaptec 2010S i2o + x86_64 doesn't work
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Markus Lidel <Markus.Lidel@shadowconnect.com>,
       Miquel van Smoorenburg <miquels@cistron.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1113588972.6694.78.camel@laptopd505.fenrus.org>
References: <20050413160352.GA12841@xs4all.net>
	 <1113576775.11116.17.camel@localhost.localdomain>
	 <1113581722.14421.15.camel@zahadum.xs4all.nl>
	 <1113587286.11114.30.camel@localhost.localdomain>
	 <426003AB.3060904@shadowconnect.com>
	 <1113588972.6694.78.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1113597812.11155.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 15 Apr 2005 21:43:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-04-15 at 19:16, Arjan van de Ven wrote:
> are you sure the HW isn't 31 bit by accident ? 

It is reported working with mem=3840 so its not 31bit, and I2O requires
32bit DMA, with option for 64bit.

Alan

