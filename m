Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289368AbSA1UM4>; Mon, 28 Jan 2002 15:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289364AbSA1UMn>; Mon, 28 Jan 2002 15:12:43 -0500
Received: from peabody.ximian.com ([141.154.95.10]:19972 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP
	id <S289367AbSA1ULz>; Mon, 28 Jan 2002 15:11:55 -0500
Subject: Re: Ethernet data corruption?
From: Kevin Breit <mrproper@ximian.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16VHub-0001Zg-00@the-village.bc.nu>
In-Reply-To: <E16VHub-0001Zg-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1.99+cvs.2002.01.23.19.37 (Preview Release)
Date: 28 Jan 2002 15:14:40 -0600
Message-Id: <1012252482.6159.9.camel@kbreit.lan>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-01-28 at 13:57, Alan Cox wrote:
> At the physical layer ethernet has hardware checksumming, at the IP/TCP layer
> there is also checksum protection. That means that its almost certainly either
> 
> -	Problem hardware/driver
The hardware on this box _is_ quite poor.  I do have a LOT of problems
with Linux on here, so this could be it.

> -	Some kind of broken transparent proxy server between the two boxes
> 
> What you really want to try is to upload the same files via different
> machines to find out which end is the problem, or if it is perhaps the
> link between them - eg does it go away only if both boxes are on the same
> LAN.
I'll try this from my desktop box tomorrow.

Thanks a lot

Kevin Breit

