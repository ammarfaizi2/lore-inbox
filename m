Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751413AbVKSMq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbVKSMq7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 07:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbVKSMq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 07:46:59 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:38350 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751413AbVKSMq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 07:46:56 -0500
Subject: Re: [PATCH 2/5] I2O: SPARC fixes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@davemloft.net>
Cc: Markus.Lidel@shadowconnect.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051118.203707.129707514.davem@davemloft.net>
References: <437E7ADB.5080200@shadowconnect.com>
	 <20051118.172230.126076770.davem@davemloft.net>
	 <1132371039.5238.14.camel@localhost.localdomain>
	 <20051118.203707.129707514.davem@davemloft.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 19 Nov 2005 13:18:35 +0000
Message-Id: <1132406315.5238.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-11-18 at 20:37 -0800, David S. Miller wrote:
> That's very possible, but it also could be that the cards
> that fail only on Sparc have Sun forth firmware on them,
> which would thus only load firmware on Sparc boxes.

The firmware on the DPT I2O card processor is kept in flash on the
processor. The BIOS setup code might be different but nothing at the
business end of things

