Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965066AbVKVSGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965066AbVKVSGv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 13:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965084AbVKVSGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 13:06:51 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:9388 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965066AbVKVSGu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 13:06:50 -0500
Subject: Re: [RFC] Small PCI core patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Avi Kivity <avi@argo.co.il>
Cc: Jeff Garzik <jgarzik@pobox.com>, Jon Smirl <jonsmirl@gmail.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Dave Airlie <airlied@gmail.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <438349F4.2080405@argo.co.il>
References: <20051121225303.GA19212@kroah.com>
	 <20051121230136.GB19212@kroah.com> <1132616132.26560.62.camel@gaston>
	 <21d7e9970511211647r4df761a2l287715368bf89eb6@mail.gmail.com>
	 <1132623268.20233.14.camel@localhost.localdomain>
	 <1132626478.26560.104.camel@gaston>
	 <9e4733910511211923r69cdb835pf272ac745ae24ed7@mail.gmail.com>
	 <43833D61.9050400@argo.co.il> <20051122155143.GA30880@havoc.gtf.org>
	 <43834400.3040506@argo.co.il> <20051122162506.GA32684@havoc.gtf.org>
	 <438349F4.2080405@argo.co.il>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 22 Nov 2005 18:38:59 +0000
Message-Id: <1132684739.20233.51.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-11-22 at 18:40 +0200, Avi Kivity wrote:
> However the situation with video drivers is already bad, and 
> deteriorating. I had to hunt on the Internet to get my recent (FC4) 
> distro to support my low-end embedded video (via). In the future it 
> looks like even that won't work.

via should work open source. It didn't in the initial FC4 X but that was
an X.org/RH bug and is fixed in the updates.

