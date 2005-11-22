Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964931AbVKVNxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964931AbVKVNxZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 08:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964938AbVKVNxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 08:53:25 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:6542 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964931AbVKVNxZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 08:53:25 -0500
Subject: Re: [RFC] Small PCI core patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Dave Airlie <airlied@gmail.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1132626478.26560.104.camel@gaston>
References: <20051121225303.GA19212@kroah.com>
	 <20051121230136.GB19212@kroah.com> <1132616132.26560.62.camel@gaston>
	 <21d7e9970511211647r4df761a2l287715368bf89eb6@mail.gmail.com>
	 <1132623268.20233.14.camel@localhost.localdomain>
	 <1132626478.26560.104.camel@gaston>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 22 Nov 2005 14:25:45 +0000
Message-Id: <1132669546.20233.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-11-22 at 13:27 +1100, Benjamin Herrenschmidt wrote:
> On the other hand, there is little justification not to open source at
> least the kernel & basic mode setting part. It's all plumbing and mode
> setting stuff, monitor detection, etc... it's not part of any of the big
> added value or IP stuff that can be found in the 3D engine.

I would concur. Although one of the problems as I understand it is the
upcoming cards no longer have a 2D engine.


