Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136137AbREGOOt>; Mon, 7 May 2001 10:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136136AbREGOOj>; Mon, 7 May 2001 10:14:39 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:35846 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S136135AbREGOOf>; Mon, 7 May 2001 10:14:35 -0400
Message-Id: <200105071414.f47EENU35387@aslan.scsiguy.com>
To: Andy Carlson <naclos@swbell.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.4-ac5 aic7xxx causes hang on my machine 
In-Reply-To: Your message of "Mon, 07 May 2001 08:04:16 CDT."
             <Pine.LNX.4.20.0105070800360.142-200000@bigandy> 
Date: Mon, 07 May 2001 08:14:23 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I have a dual ppro 200MHZ W6LI motherboard.  I put 2.4.4-ac5 on last
>night, and the machine hung at Freeing unused Kernel memory.  I
>selectively backed off what I thought were relevant patches.  I got to
>aic7xxx, and ac5 without it worked. I attached /proc/scsi/aic7xxx/0.

This problem was fixed in rev. 6.1.13 of the aic7xxx driver.

--
Justin
