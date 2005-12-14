Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964990AbVLNVTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964990AbVLNVTJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 16:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964973AbVLNVTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 16:19:09 -0500
Received: from nproxy.gmail.com ([64.233.182.201]:9153 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932352AbVLNVTG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 16:19:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jh5CYi9r7LjDc4g7keWnqqxYSBel85gorJs1f9cOR2b9KEK+AZHTKoxts6tZm191tBcVTxXE+sDxvSam4vUt1WgGC4qmHtDvAyG6Yyt0uKdIMPdsvYGq3ZcD0dj208ZDJRrR6X2fsMnNGKpflVNTV+xc7Ony3p/ZIuxknw3P93k=
Message-ID: <58cb370e0512141319q2ce4bd9as510b3b353beb78b@mail.gmail.com>
Date: Wed, 14 Dec 2005 22:19:05 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH RESEND] via82cxxx IDE: Add VT8251 ISA bridge
Cc: Daniel Drake <dsd@gentoo.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <43989AB9.60203@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43988D11.80809@gentoo.org> <43989AB9.60203@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

applied

On 12/8/05, Jeff Garzik <jgarzik@pobox.com> wrote:
> Daniel Drake wrote:
> > Some motherboards (such as the Asus P5V800-MX) ship a
> > PCI_DEVICE_ID_VIA_82C586_1 IDE controller alongside a VT8251 southbridge.
> >
> > This southbridge is currently unrecognised in the via82cxxx IDE driver,
> > preventing those users from getting DMA access to disks.
> >
> > Signed-off-by: Daniel Drake <dsd@gentoo.org>
> >
> > --
> >
> > Bart, I submitted this 2 weeks ago but sent it to your old pw.edu.pl
> > address by accident. Sorry about that!
>
> ACK.
>
> VIA sent me the same patch, privately.
