Return-Path: <linux-kernel-owner+w=401wt.eu-S1755396AbXABRTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755396AbXABRTu (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 12:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755398AbXABRTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 12:19:50 -0500
Received: from smtp.telefonica.net ([213.4.149.66]:64366 "EHLO
	ctsmtpout3.frontal.correo" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755396AbXABRTt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 12:19:49 -0500
From: Jose Alberto Reguero <jareguero@telefonica.net>
To: linux-kernel@vger.kernel.org
Subject: Re: pata_marvell and Marvell 88SE6121
Date: Tue, 2 Jan 2007 18:19:46 +0100
User-Agent: KMail/1.9.5
References: <200612161841.26700.jareguero@telefonica.net>
In-Reply-To: <200612161841.26700.jareguero@telefonica.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200701021819.47048.jareguero@telefonica.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sábado, 16 de Diciembre de 2006 18:41, Jose Alberto Reguero escribió:
> I am trying to make work the driver pata_marvell of linux-2.6.20-rc1 with
> Marvell 88SE6121.
> I added the PCI ID: 0x6121
>
>         { PCI_DEVICE(0x11AB, 0x6101), },
>         { PCI_DEVICE(0x11AB, 0x6145), },
>         { PCI_DEVICE(0x11AB, 0x6121), },
>         { }     /* terminate list */
>
> But not succes.
>
It is posible to configure three ports (more than two ports) with this driver?

Thanks.
Jose Alberto
