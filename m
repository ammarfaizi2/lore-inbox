Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265489AbUIOPMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265489AbUIOPMQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 11:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266311AbUIOPMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 11:12:16 -0400
Received: from gate.crashing.org ([63.228.1.57]:8857 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265489AbUIOPMP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 11:12:15 -0400
Subject: Re: keylargo PCI USB controller nor enabled on G4 xserve
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Thomas Unger <unger@informatik.uni-siegen.de>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <41485359.80602@informatik.uni-siegen.de>
References: <41485359.80602@informatik.uni-siegen.de>
Content-Type: text/plain
Message-Id: <1095260769.2665.471.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 16 Sep 2004 01:06:12 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-16 at 00:36, Thomas Unger wrote:

> looks to me like a pci problem as the device obviously isn't even
> enumerated. I tried several 2.6 versions, none of them fixed this.
> 
> Has anyone had similar problems or even a solution to this?
> Any help is welcome.

There's something wrong with PCI enumeration on the Xserve G4 in 2.6,
though I haven't yet figured out what exactly. Ideally, I would need
to have physical access to one of these to fix it ... anybody in .au ?

Ben.


