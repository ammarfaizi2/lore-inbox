Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292582AbSBTXrh>; Wed, 20 Feb 2002 18:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292588AbSBTXr1>; Wed, 20 Feb 2002 18:47:27 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11023 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292590AbSBTXrQ>; Wed, 20 Feb 2002 18:47:16 -0500
Subject: Re: lseek SEEK_END fails on a Toshiba 6007MB disk.
To: kallol@efi.com (Kallol Biswas)
Date: Thu, 21 Feb 2002 00:01:37 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C7433F8.8FB86B39@efi.com> from "Kallol Biswas" at Feb 20, 2002 03:40:40 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16dgg5-0005BQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> # ./seek
> lseek: Value too large for defined data type
> 
> The system runs 2.4.17 kernel.

This is correct behaviour
