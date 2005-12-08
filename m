Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbVLHUmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbVLHUmm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 15:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbVLHUmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 15:42:42 -0500
Received: from mail.dvmed.net ([216.237.124.58]:4523 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932326AbVLHUml (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 15:42:41 -0500
Message-ID: <43989AB9.60203@pobox.com>
Date: Thu, 08 Dec 2005 15:42:33 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Drake <dsd@gentoo.org>
CC: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] via82cxxx IDE: Add VT8251 ISA bridge
References: <43988D11.80809@gentoo.org>
In-Reply-To: <43988D11.80809@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Daniel Drake wrote: > Some motherboards (such as the
	Asus P5V800-MX) ship a > PCI_DEVICE_ID_VIA_82C586_1 IDE controller
	alongside a VT8251 southbridge. > > This southbridge is currently
	unrecognised in the via82cxxx IDE driver, > preventing those users from
	getting DMA access to disks. > > Signed-off-by: Daniel Drake
	<dsd@gentoo.org> > > -- > > Bart, I submitted this 2 weeks ago but sent
	it to your old pw.edu.pl > address by accident. Sorry about that! [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Drake wrote:
> Some motherboards (such as the Asus P5V800-MX) ship a
> PCI_DEVICE_ID_VIA_82C586_1 IDE controller alongside a VT8251 southbridge.
> 
> This southbridge is currently unrecognised in the via82cxxx IDE driver,
> preventing those users from getting DMA access to disks.
> 
> Signed-off-by: Daniel Drake <dsd@gentoo.org>
> 
> -- 
> 
> Bart, I submitted this 2 weeks ago but sent it to your old pw.edu.pl 
> address by accident. Sorry about that!

ACK.

VIA sent me the same patch, privately.

	Jeff



