Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261721AbUL3VtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbUL3VtY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 16:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbUL3VtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 16:49:24 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:29708 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261721AbUL3VtV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 16:49:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=heBKMKmwi/w4vPRNRoMrtdjCx7NNIJyXmZG5CSQ/Ug/45Hiy6dtngap39Mjdo/bIVzfgUCAIpM49BOQrw63rEn6zSaSeuVGWY3WdqNfxFF2roWRKyTWhvHU8QJDGI51A2zpTXStEm02WbwiBeeHHH7pO1na0LnxImRkis7w5klM=
Message-ID: <58cb370e041230134826287c5@mail.gmail.com>
Date: Thu, 30 Dec 2004 22:48:53 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Jason Gaston <jason.d.gaston@intel.com>
Subject: Re: [PATCH] PATA support for Intel ICH7 - 2.6.10 - repost
Cc: jgarzik@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <200412300613.07427.jason.d.gaston@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200412300613.07427.jason.d.gaston@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 30 Dec 2004 06:13:07 -0800, Jason Gaston
<jason.d.gaston@intel.com> wrote:
> Reposting patch with word wrap turned off.  Please let me know if this is still not formated correctly.
> 
> This patch adds the Intel ICH7 DID's to the pci_ids.h file and updates the piix driver and related files for PATA support.

this patch also seems to add PIRQ support

> If acceptable, please apply.
> 
> Thanks,

applied
