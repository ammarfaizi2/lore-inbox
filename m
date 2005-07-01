Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263436AbVGATJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263436AbVGATJb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 15:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbVGATJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 15:09:31 -0400
Received: from mail.kroah.org ([69.55.234.183]:43959 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263437AbVGATJ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 15:09:27 -0400
Date: Fri, 1 Jul 2005 12:09:04 -0700
From: Greg KH <greg@kroah.com>
To: christos gentsis <christos_gentsis@yahoo.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI-X support
Message-ID: <20050701190904.GA32466@kroah.com>
References: <42C58203.40606@yahoo.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C58203.40606@yahoo.co.uk>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2005 at 06:48:51PM +0100, christos gentsis wrote:
> Hello
> 
> I have a friend that his Msc project is related with the development 
> over a PCI-X card. the problem is that he do not know if the Linux 
> kernel support the PCI-X bus.

Yes.  But I don't think we support PCI-X 2.0, but as there are no
chipsets out yet that support that, I don't think you should worry about
that :)

Good luck,

greg k-h
