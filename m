Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030223AbVKVXAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030223AbVKVXAe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 18:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030226AbVKVXAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 18:00:34 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:1490 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030223AbVKVXAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 18:00:32 -0500
Subject: Re: Christmas list for the kernel
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Jon Smirl <jonsmirl@gmail.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20051122204918.GA5299@kroah.com>
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com>
	 <20051122204918.GA5299@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 22 Nov 2005 23:33:02 +0000
Message-Id: <1132702382.20233.85.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-11-22 at 12:49 -0800, Greg KH wrote:
> What driver subsystem is not hotplugable and does not have automatically
> loaded modules today?

IDE is the one I kind of notice the most.

There are others too like ISAPnP hotplug on dock events, and BIOSPnP
dock hotplug but those are deeply obscure and dying out.


