Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261224AbVAMQo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbVAMQo0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 11:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVAMQmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 11:42:55 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:32228 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261226AbVAMQlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 11:41:09 -0500
Subject: Re: NUMA or not on dual Opteron (was: Re: Linux 2.6.11-rc1)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: sander@humilis.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Sergey S. Kostyliov" <rathamahata@ehouse.ru>
In-Reply-To: <20050113094537.GB2547@favonius>
References: <Pine.LNX.4.58.0501112100250.2373@ppc970.osdl.org>
	 <200501121824.44327.rathamahata@ehouse.ru>
	 <Pine.LNX.4.58.0501120730490.2373@ppc970.osdl.org>
	 <20050113094537.GB2547@favonius>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105629224.4664.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 13 Jan 2005 15:36:46 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-01-13 at 09:45, Sander wrote:
> In other words: why should one want NUMA to be enabled or disabled for
> dual Opteron?

When it makes it faster - which for me with builds and stuff seems ot be
true of a dual Opteron

