Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262346AbUKKSc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262346AbUKKSc7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 13:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262332AbUKKSai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 13:30:38 -0500
Received: from fmr06.intel.com ([134.134.136.7]:15817 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S262347AbUKKSaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 13:30:08 -0500
From: Mark Gross <mgross@linux.intel.com>
Organization: Intel
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: Re: Wanted: small number of crazy highpoint IDE  (HPT366-372N/374) controller owners
Date: Thu, 11 Nov 2004 10:23:29 -0800
User-Agent: KMail/1.5.4
References: <1100111436.20556.15.camel@localhost.localdomain>
In-Reply-To: <1100111436.20556.15.camel@localhost.localdomain>
Cc: markgross@thegnar.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411111023.29336.mgross@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 November 2004 10:30, Alan Cox wrote:
> I've been debugging and chasing down various HPT IDE problems. I've done
> some cleanups, fixed the PLL tune and little bits like that. These are
> the kind of changes that turn your disk into a random number generator
> if they go wrong but OTOH the HPT372N crashes should be fixed.
>
> Now it needs some testers...
>
> Alan
>

I have a retiered BP6 at home I could try to bring up this weekend.  The only 
problem is that I haven't been able to boot a 2.6 kernel from the HPT 366 
attached drive it as the device id's seem to have been shuffeled about on me.  
hdd goes to something else or so i thought before I gave up on the thing.

I could put 2 IDE's in it one on the 366 and one on the chipset IDE 
controllers to get the thing to boot up.

just let me know.

--mgross

