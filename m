Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbVA1BxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbVA1BxQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 20:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbVA1BxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 20:53:16 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17295 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261383AbVA1BxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 20:53:03 -0500
Message-ID: <41F99AF0.4090902@pobox.com>
Date: Thu, 27 Jan 2005 20:52:48 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Sims <dpsims@virtualdave.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: I need a hardware wizard... I have been beating my head on the
 wall..
References: <Pine.LNX.4.21.0501271929270.26803-100000@ernie.virtualdave.com>
In-Reply-To: <Pine.LNX.4.21.0501271929270.26803-100000@ernie.virtualdave.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Sims wrote:
> Hi,
> 
>   I have posted a couple of times in the past to no avail... I have an
> Intel 31244 SATA controller that is supposed to work with the sata_vsc
> driver module... It does in fact, almost....
> 
>   You can insert the module in a running kernel and after barking as
> follows (once for each disk attached) it runs just fine.

Basically nobody has ever had hardware to test sata_vsc with that 
hardware.  We should probably remove the PCI ID until an engineer can 
fix it...

	Jeff



