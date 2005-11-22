Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030230AbVKVXCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030230AbVKVXCn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 18:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030229AbVKVXCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 18:02:43 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:41164 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030227AbVKVXCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 18:02:41 -0500
Subject: Re: Christmas list for the kernel
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <9e4733910511221313t4a1e3c67wc7b08160937eb5c5@mail.gmail.com>
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com>
	 <20051122204918.GA5299@kroah.com>
	 <9e4733910511221313t4a1e3c67wc7b08160937eb5c5@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 22 Nov 2005 23:35:05 +0000
Message-Id: <1132702505.20233.88.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-11-22 at 16:13 -0500, Jon Smirl wrote:
> All of the legacy stuff - VGA, Vesafb, PS2, serial, parallel,

PCI Parallel and serial hotplug
PS2 hotplugs if you've got hotpluggable PS2 - I've even used this
Most Joysticks hotplug
Gameports mostly hotplug
VESAfb is by definition not hotplug capable
VGA hotplug we don't do but you can load the module.


Alan

