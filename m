Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265287AbUBFBtb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 20:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265303AbUBFBtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 20:49:31 -0500
Received: from mailout.zma.compaq.com ([161.114.64.103]:63505 "EHLO
	zmamail03.zma.compaq.com") by vger.kernel.org with ESMTP
	id S265287AbUBFBta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 20:49:30 -0500
Date: Thu, 5 Feb 2004 19:54:02 -0600 (CST)
From: mikem@beardog.cca.cpqcorp.net
To: Greg KH <greg@kroah.com>
Cc: axboe@suse.de, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: cciss updates for 2.6 [1 of 11]
In-Reply-To: <20040206010912.GE18681@kroah.com>
Message-ID: <Pine.LNX.4.58.0402051953010.18320@beardog.cca.cpqcorp.net>
References: <Pine.LNX.4.58.0402041737080.18320@beardog.cca.cpqcorp.net>
 <20040206010912.GE18681@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Feb 2004, Greg KH wrote:

> On Wed, Feb 04, 2004 at 06:04:46PM -0600, mikem@beardog.cca.cpqcorp.net wrote:
> > +
> > +static int find_PCI_BAR_index(struct pci_dev *pdev,
> > +				unsigned long pci_bar_addr)
>
> What are you trying to do here that the PCI core doesn't do already?
>
> thanks,
>
> greg k-h
>
I've already been informed of pci_request_regions. Thanks for your input.

mikem
