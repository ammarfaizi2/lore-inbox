Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265840AbUHDNsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265840AbUHDNsD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 09:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265893AbUHDNsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 09:48:03 -0400
Received: from 23-88.ipact.nl ([82.210.88.23]:63130 "EHLO vt.shuis.tudelft.nl")
	by vger.kernel.org with ESMTP id S265840AbUHDNr7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 09:47:59 -0400
From: Remon <noreply@vt.shuis.tudelft.nl>
Reply-To: noreply@vt.shuis.tudelft.nl
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-O3
Date: Wed, 4 Aug 2004 15:48:46 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408041548.46648.noreply@vt.shuis.tudelft.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I tried to compile this one, but got an error on:

drivers/pci/hotplug/cpci_hotplug_core.c : unknown field `generic_disable_irq' 
specified in initializer

I disabled hotplug in the config file and the compilation succeeded without 
problems ;-) (I don't need hotplug, but maybe others do)

Thanks for all the work done, I'm gonna test it now :-)

Remon

