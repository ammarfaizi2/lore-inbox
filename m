Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261826AbVDOOz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbVDOOz5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 10:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261829AbVDOOz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 10:55:56 -0400
Received: from [81.2.110.250] ([81.2.110.250]:63174 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261826AbVDOOzr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 10:55:47 -0400
Subject: Re: Adaptec 2010S i2o + x86_64 doesn't work
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Markus.Lidel@shadowconnect.com
In-Reply-To: <20050413160352.GA12841@xs4all.net>
References: <20050413160352.GA12841@xs4all.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1113576775.11116.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 15 Apr 2005 15:52:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-04-13 at 17:03, Miquel van Smoorenburg wrote:
> I have a supermicro dual xeon em64t system, X6DH8-XG2 motherboard,
> 4 GB RAM, with an Adaptec zero raid 2010S i2o controller. In 32
> bits mode it runs fine, both with the dpt_i2o driver and the
> generic i2o_block driver using kernel 2.6.11.6.

Does it work if you drop the box to 2Gbytes ?


