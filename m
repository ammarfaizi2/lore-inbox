Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965149AbVKVTpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965149AbVKVTpb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 14:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965151AbVKVTpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 14:45:31 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:27341 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965149AbVKVTpb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 14:45:31 -0500
Subject: Re: [RFC] Small PCI core patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <9e4733910511220854m2c5ffbe0t67a53f6bae89653@mail.gmail.com>
References: <20051121225303.GA19212@kroah.com>
	 <20051121230136.GB19212@kroah.com> <1132616132.26560.62.camel@gaston>
	 <9e4733910511220854m2c5ffbe0t67a53f6bae89653@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 22 Nov 2005 20:17:56 +0000
Message-Id: <1132690676.20233.72.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-11-22 at 11:54 -0500, Jon Smirl wrote:
> Removal of the 2D engines is a key vulnerability in the strategy of
> only using 2D on Linux.

I must have missed something, there isn't such a strategy anywhere I
know either in X or in the kernel. EXA in X is designed to make using
the 3D engine to do the 2D rendering much easier.

