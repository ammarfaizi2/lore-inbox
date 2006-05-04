Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030277AbWEDV5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030277AbWEDV5M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 17:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030280AbWEDV5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 17:57:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1991 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030277AbWEDV5L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 17:57:11 -0400
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow
	userspace (Xorg) to enable devices without doing foul direct access
From: Peter Jones <pjones@redhat.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, Dave Airlie <airlied@linux.ie>,
       Andrew Morton <akpm@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>
In-Reply-To: <9e4733910605041448j431266d5x8669f79bd1b36e18@mail.gmail.com>
References: <1146300385.3125.3.camel@laptopd505.fenrus.org>
	 <200605041309.53910.bjorn.helgaas@hp.com>
	 <445A51F1.9040500@linux.intel.com>
	 <200605041326.36518.bjorn.helgaas@hp.com>
	 <E1FbjiL-0001B9-00@chiark.greenend.org.uk>
	 <9e4733910605041340r65d47209h2da079d9cf8fceae@mail.gmail.com>
	 <1146776736.27727.11.camel@localhost.localdomain>
	 <9e4733910605041418n2105e50bs8803cd6ac8407c48@mail.gmail.com>
	 <1146778720.27727.35.camel@localhost.localdomain>
	 <9e4733910605041448j431266d5x8669f79bd1b36e18@mail.gmail.com>
Content-Type: text/plain
Organization: Red Hat, Inc.
Date: Thu, 04 May 2006 17:57:01 -0400
Message-Id: <1146779821.27727.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-05-04 at 17:48 -0400, Jon Smirl wrote:

> Let me be clear here. A lot of laptop video hardware does not have a
> video ROM.

Why do you assume we're only talking about laptops?

-- 
  Peter

