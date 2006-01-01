Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWAAR4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWAAR4V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 12:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbWAAR4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 12:56:20 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:56250 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S932168AbWAAR4U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 12:56:20 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: "1qay beer" <1qay@beer.com>
Subject: Re: Wish for 2006 to Alan Cox and Jeff Garzik: A functional Driver for PDC202XX
Date: Sun, 1 Jan 2006 17:56:08 +0000
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org
References: <20060101173909.D30257B386@ws5-10.us4.outblaze.com>
In-Reply-To: <20060101173909.D30257B386@ws5-10.us4.outblaze.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601011756.08694.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 01 January 2006 17:39, 1qay beer wrote:
> Hello,
> Dear Alan Cox,
> Dear Jeff Garzik,
>
> Everyone a happy new year!
>
> We are in stable Kernel 2.6.14.5, year 2006.
> Since 1997 people asking on several list for a functional PDC202XX Driver.
> Since some years I spend hours and hours finding a solution for a stable
> driver. (PDC20269/Promise Ultra133 TX2)
> There seem to be none.
>
> There are two Solution:
> -The IDE Driver (pdc202xx_new) has still problems with "DMA Timeout".
> -The Libata Driver (pata_pdc2027x) seems to be still somewhat experimental.
>
> Unfortunatly I'am not a kernel developper else there would be probably
> already a solution ;-)
>
> So what is the Solution for the PDC20269 Ultra ATA Controller?
> I would mark this bold on the wishlist for 2006 ;-)

I own this controller and it's been working with the kernel driver since 
2002.. I'm not sure what you expect people to do about clearly faulty 
hardware. Just buy a new one?

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
