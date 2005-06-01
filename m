Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261319AbVFAHc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbVFAHc1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 03:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbVFAHc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 03:32:26 -0400
Received: from mail.dvmed.net ([216.237.124.58]:56965 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261309AbVFAHcV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 03:32:21 -0400
Message-ID: <429D647F.5020701@pobox.com>
Date: Wed, 01 Jun 2005 03:32:15 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg K-H <greg@kroah.com>
CC: linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       acurrid@nvidia.com
Subject: Re: [PATCH] PCI: amd74xx patch for new NVIDIA device IDs
References: <111760252426@kroah.com>
In-Reply-To: <111760252426@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> [PATCH] PCI: amd74xx patch for new NVIDIA device IDs
> 
> Here's the 2.6 amd74xx patch for NVIDIA MCP51.
> 
> Signed-off-by: Andy Currid <acurrid@nvidia.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> ---
> commit af00f9811e0ccbd3db84ddc4cffb0da942653393
> tree 5a9c3b7f7d61d96d3624ad130b173a761cb7dac2
> parent 2ac2610b26c9da72820443328ff2c56c7b8c87b8
> author Andy Currid <acurrid@nvidia.com> Mon, 23 May 2005 08:55:45 -0700
> committer Greg KH <gregkh@suse.de> Tue, 31 May 2005 14:26:38 -0700
> 
>  drivers/ide/pci/amd74xx.c |    3 +++
>  include/linux/pci_ids.h   |    6 ++++++


This is hardly a PCI patch.

Has Bart, the IDE maintainer, acked this?

	Jeff


