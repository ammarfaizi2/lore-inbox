Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964898AbWBAECm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbWBAECm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 23:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbWBAECm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 23:02:42 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:34276 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S964859AbWBAECl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 23:02:41 -0500
Message-ID: <43E032DD.4040203@freescale.com>
Date: Tue, 31 Jan 2006 21:02:37 -0700
From: Matt Waddel <Matt.Waddel@freescale.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: License oddity in some m68k files
References: <43D17F4D.2010003@freescale.com> <1138644231.31089.77.camel@localhost.localdomain>
In-Reply-To: <1138644231.31089.77.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Gwe, 2006-01-20 at 17:24 -0700, Matt Waddel wrote:
> 
>>I have been given permission to fix the "UNPUBLISHED PROPRIETARY
>>SOURCE CODE OF MOTOROLA ..." section in the source files of fpsp040/
>>directory.
>>
>>One suggestion, so we don't have to revisit this topic in 16 years
>>from now again, shouldn't we just remove the UNPUBLISHED ... comment
>>altogether and replace it with Greg Kroah-Hartman's suggested verbiage
>>as in the patch below?
> 
> 
> Looks sensible (sorry was a bit busy) and now catching up on email. Does
> need a "signed-off-by:" line.
> 

Hi Alan,

There was a "signed-off-by:" line just before the diff started.  Sorry
if it was buried too far down.  Do you need me to resend the patch
again?

Regards,
Matt

Signed-off-by: Matt Waddel <matt.waddel@freescale.com>

> 
> Thanks
> Alan
> 
> 
