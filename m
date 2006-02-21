Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161278AbWBUCRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161278AbWBUCRq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 21:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161279AbWBUCRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 21:17:46 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:34696 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S1161278AbWBUCRp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 21:17:45 -0500
From: Francesco Biscani <biscani@pd.astro.it>
To: Mark Lord <lkml@rtr.ca>
Subject: Re: libata PATA drivers patch for 2.6.16-rc4
Date: Tue, 21 Feb 2006 03:17:39 +0100
User-Agent: KMail/1.9.1
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <1140445182.26526.1.camel@localhost.localdomain> <200602202226.43772.biscani@pd.astro.it> <43FA3EB2.30002@rtr.ca>
In-Reply-To: <43FA3EB2.30002@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200602210317.40079.biscani@pd.astro.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 February 2006 23:12, Mark Lord wrote:
> Dunno.  For some odd reason libata still doesn't want to handle ATAPI
> devices out-of-the-box.  There's a boot/module option for it, though,
> as well as this patch (attached).

Thanks! Now I see the cdrom drive, albeit as /dev/sdb... (see other mail)

-- 
Dr. Francesco Biscani
Dipartimento di Astronomia
Università di Padova
biscani@pd.astro.it
