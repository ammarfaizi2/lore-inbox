Return-Path: <linux-kernel-owner+w=401wt.eu-S932221AbXAOLHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbXAOLHy (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 06:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbXAOLHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 06:07:53 -0500
Received: from mail.first.fraunhofer.de ([194.95.169.2]:49190 "EHLO
	mail.first.fraunhofer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932221AbXAOLHx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 06:07:53 -0500
Subject: prioritize PCI traffic ?
From: Soeren Sonnenburg <kernel@nn7.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 15 Jan 2007 12:07:45 +0100
Message-Id: <1168859265.15294.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

is it possible to explicitly tell the kernel to prioritize PCI traffic
for a number of cards in pci slots x,y,z ?

I am asking as severe ide traffic causes lost frames when watching TV
using 2 DVB cards + vdr... This is simply due to the fact that the PCI
bus is saturated...

So, is any prioritizing of the PCI bus possible ?

Best
Soeren
-- 
Sometimes, there's a moment as you're waking, when you become aware of
the real world around you, but you're still dreaming.
