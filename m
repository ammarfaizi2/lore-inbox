Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289090AbSAJAKT>; Wed, 9 Jan 2002 19:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289092AbSAJAKJ>; Wed, 9 Jan 2002 19:10:09 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46852 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289090AbSAJAJz>; Wed, 9 Jan 2002 19:09:55 -0500
Subject: Re: initramfs programs (was [RFC] klibc requirements)
To: hpa@zytor.com (H. Peter Anvin)
Date: Thu, 10 Jan 2002 00:21:30 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <a1ijm9$hcl$1@cesium.transmeta.com> from "H. Peter Anvin" at Jan 09, 2002 03:28:09 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16OSyI-0002m8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We have also been over the fact that dmidecode, if written
> appropriately, could be setuid, or call a "dmicat" setuid program.
> This is a dmidecode implementation detail.

We've also proved the DMI data is too unreliable to be used, so the entire
problem space is irrelevant
