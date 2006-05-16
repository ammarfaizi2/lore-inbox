Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751782AbWEPNuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751782AbWEPNuQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 09:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbWEPNuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 09:50:15 -0400
Received: from host70.simplicato.com ([207.99.47.70]:46305 "EHLO
	mail11.simplicato.com") by vger.kernel.org with ESMTP
	id S1751782AbWEPNuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 09:50:13 -0400
From: "Zvi Gutterman" <zvi@safend.com>
To: "'Muli Ben-Yehuda'" <muli@il.ibm.com>,
       "'Kyle Moffett'" <mrmacman_g4@mac.com>
Cc: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'Jonathan Day'" <imipak@yahoo.com>, <linux-kernel@vger.kernel.org>
Subject: RE: /dev/random on Linux
Date: Tue, 16 May 2006 16:54:00 +0300
Message-ID: <00fc01c678f0$30c77520$2c02a8c0@Safend.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <20060516082859.GD18645@rhun.haifa.ibm.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Thread-Index: AcZ4w5Mw9zwAhXKKTkOxawfwLPgMlQAKoqfw
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello All,

I did not get any answer from Matt and was sure that it was of no interest.
This was my mistake, sorry for not sending it earlier to more people.
 
I will be very happy to discuss any aspect of the paper and we do suggest
ways we think can improve the /dev/random security (a very simple issue for
example is implementing quotas on the consumption of random numbers)

Thanks,

Zvi
 

-----Original Message-----
From: Muli Ben-Yehuda [mailto:muli@il.ibm.com] 
Sent: Tuesday, May 16, 2006 11:29 AM
To: Kyle Moffett
Cc: Alan Cox; Jonathan Day; linux-kernel@vger.kernel.org; Zvika Gutterman
Subject: Re: /dev/random on Linux

On Tue, May 16, 2006 at 04:15:19AM -0400, Kyle Moffett wrote:
> On May 15, 2006, at 22:50, Muli Ben-Yehuda wrote:
> >On Mon, May 15, 2006 at 11:41:07PM +0100, Alan Cox wrote:
> >>A paper by people who can't work out how to mail linux-kernel or  
> >>vendor-sec, or follow "REPORTING-BUGS" in the source,
> >
> >Zvi did contact Matt Mackall, the current /dev/random maintainer,  
> >and was very keen on discussing the paper with him. I don't think  
> >he got any response.
> 
> So he's demanding that one person spend time responding to his  
> paper? 

Who said anything about demanding? he wanted to discuss the paper. He
received no response (AFAIK). Please don't read more into it.

> The "maintainer" for any given piece of the kernel is the  
> entry in MAINTAINERS *and* linux-kernel@vger.kernel.org *and* the  
> appropriate sub-mailing-list.

For security related information, it is sometimes best not to tell the
whole world about it immediately (although you should definitely tell
the whole world about it eventually). It should've probably been
posted to lkml when mpm didn't respond, I agree. I'll take the blame
for not suggesting that to Zvi.

Cheers,
Muli


