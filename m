Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263037AbUCMC4G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 21:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263038AbUCMC4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 21:56:06 -0500
Received: from grebe.mail.pas.earthlink.net ([207.217.120.46]:11964 "EHLO
	grebe.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S263037AbUCMC4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 21:56:03 -0500
Date: Fri, 12 Mar 2004 18:55:51 -0800
From: Lee Howard <faxguy@howardsilvan.com>
To: linux-kernel@vger.kernel.org
Subject: address space collision on PCI bridge
Message-ID: <20040313025551.GA1769@bilbo.x101.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can someone explain this address space collision to me and offer an 
explanation on how to resolve it?

 From dmesg:

PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Address space collision on region 7 of bridge 0000:00:04.3 
[e400:e43f]
PCI: Address space collision on region 8 of bridge 0000:00:04.3 
[e800:e81f]
PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:04.0

Thanks.

Lee.
