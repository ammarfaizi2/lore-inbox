Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbVFAJuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVFAJuY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 05:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbVFAJuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 05:50:24 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:3234 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261164AbVFAJuP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 05:50:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HbmYcHKMjbm349naYWe644+PjnKD0w4LsFgMuE/D93chdhqRNOTjrcU4//WEbstwN9ODKmJpvtfHpAicgsP8T8VR19E07Qkz4gIGvMW8k/GlMypkaQlqkecL5osFUi0xD/oO5SpVE9xSDK+n7sN1wmOGepllDaw1O+lPwMUAEzk=
Message-ID: <58cb370e05060102504fa06c4c@mail.gmail.com>
Date: Wed, 1 Jun 2005 11:50:14 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] PCI: amd74xx patch for new NVIDIA device IDs
Cc: Greg K-H <greg@kroah.com>, linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       acurrid@nvidia.com
In-Reply-To: <429D647F.5020701@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <111760252426@kroah.com> <429D647F.5020701@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/05, Jeff Garzik <jgarzik@pobox.com> wrote:
> Greg KH wrote:
> > [PATCH] PCI: amd74xx patch for new NVIDIA device IDs
> >
> > Here's the 2.6 amd74xx patch for NVIDIA MCP51.
> >
> > Signed-off-by: Andy Currid <acurrid@nvidia.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> >
> > ---
> > commit af00f9811e0ccbd3db84ddc4cffb0da942653393
> > tree 5a9c3b7f7d61d96d3624ad130b173a761cb7dac2
> > parent 2ac2610b26c9da72820443328ff2c56c7b8c87b8
> > author Andy Currid <acurrid@nvidia.com> Mon, 23 May 2005 08:55:45 -0700
> > committer Greg KH <gregkh@suse.de> Tue, 31 May 2005 14:26:38 -0700
> >
> >  drivers/ide/pci/amd74xx.c |    3 +++
> >  include/linux/pci_ids.h   |    6 ++++++
> 
> 
> This is hardly a PCI patch.
> 
> Has Bart, the IDE maintainer, acked this?
> 
>         Jeff
> 

Thanks Jeff.

Ack.
