Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262113AbUKJT6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbUKJT6K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 14:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbUKJT6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 14:58:10 -0500
Received: from [81.23.229.73] ([81.23.229.73]:22156 "EHLO mail.eduonline.nl")
	by vger.kernel.org with ESMTP id S262113AbUKJT6J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 14:58:09 -0500
From: Norbert van Nobelen <Norbert@edusupport.nl>
Organization: EduSupport
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Wanted: small number of crazy highpoint IDE  (HPT366-372N/374) controller owners
Date: Wed, 10 Nov 2004 20:58:05 +0100
User-Agent: KMail/1.6.2
References: <1100111436.20556.15.camel@localhost.localdomain>
In-Reply-To: <1100111436.20556.15.camel@localhost.localdomain>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200411102058.05982.Norbert@edusupport.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can see volunteers line up already with this kind of incentive (-:

Sorry, already have a not so trustable SATA controller, a possibly broken IDE  
disk in a software raid5 array, and just survived another SCSI disk crash. 
This one will pass me by by lack of the mentioned controller. If someone 
sends me one, I don't have problem with testing it, machines and disks 
enough.

On Wednesday 10 November 2004 19:30, you wrote:
> I've been debugging and chasing down various HPT IDE problems. I've done
> some cleanups, fixed the PLL tune and little bits like that. These are
> the kind of changes that turn your disk into a random number generator
> if they go wrong but OTOH the HPT372N crashes should be fixed.
>
> Now it needs some testers...
>
> Alan
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
