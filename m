Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbTJXSeI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 14:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbTJXSeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 14:34:08 -0400
Received: from web14915.mail.yahoo.com ([216.136.225.228]:57761 "HELO
	web14915.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262429AbTJXSeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 14:34:06 -0400
Message-ID: <20031024183405.36600.qmail@web14915.mail.yahoo.com>
Date: Fri, 24 Oct 2003 11:34:04 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [Dri-devel] Re: [Linux-fbdev-devel] DRM and pci_driver conversion
To: Linus Torvalds <torvalds@osdl.org>, Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Jeff Garzik <jgarzik@pobox.com>, Jon Smirl <jonsmirl@yahoo.com>,
       Eric Anholt <eta@lclark.edu>, kronos@kronoz.cjb.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net,
       dri-devel <dri-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0310241051450.8177-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PCI ROM enabale/disable has come up before on LKML. Russell made this comment
about making the code more portable.

--- Russell King <rmk@arm.linux.org.uk> wrote:
> You should use pcibios_resource_to_bus() to convert a resource to a
> representation suitable for a BAR.

http://lkml.org/lkml/2003/8/19/279


=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com
