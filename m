Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132824AbRDITvV>; Mon, 9 Apr 2001 15:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132832AbRDITvK>; Mon, 9 Apr 2001 15:51:10 -0400
Received: from mlist.austria.eu.net ([193.81.83.3]:49295 "EHLO
	hausmasta.austria.eu.net") by vger.kernel.org with ESMTP
	id <S132824AbRDITvE>; Mon, 9 Apr 2001 15:51:04 -0400
Message-ID: <3AD21264.7EA4C687@eunet.at>
Date: Mon, 09 Apr 2001 21:49:56 +0200
From: Michael Reinelt <reinelt@eunet.at>
Organization: netWorks
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ISIcom cards by Multi-tech
In-Reply-To: <E14mge5-0002ed-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-AntiVirus: OK (checked by AntiVir Version 6.6.0.12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > As multitech seems not to provide a driver for 2.4, someone must have
> > ported the 2.2 driver to 2.4. I'd like to talk to this person, and help
> > merging the 2.2 updates to 2.4.
> 
> I did a quick port of the old driver over (it wasnt very hard) and people then
> added additional bits of support later.
> 
> multitech never sent me many updates

O well. I thought it went this way....

Do you have sort of a 'patch' from your port? I could take this as a
guideline for what has to be changed from 2.2 to 2.4. If I compare the
2.4 driver to the actual 2.2 one, there are far too much differences for
me...

bye, Michael

-- 
netWorks       	                                  Vox: +43 316  692396
Michael Reinelt                                   Fax: +43 316  692343
Geisslergasse 4					  GSM: +43 676 3079941
A-8045 Graz, Austria			      e-mail: reinelt@eunet.at
