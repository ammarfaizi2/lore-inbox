Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422717AbWJXWUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422717AbWJXWUF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 18:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422721AbWJXWUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 18:20:04 -0400
Received: from dialup-63-108-131-26.nehp.net ([63.108.131.26]:31421 "EHLO
	waltsathlon.localhost.net") by vger.kernel.org with ESMTP
	id S1422718AbWJXWUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 18:20:00 -0400
Message-ID: <453E918B.4020909@lorettotel.net>
Date: Tue, 24 Oct 2006 17:19:55 -0500
From: Walt H <walt_h@lorettotel.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.7) Gecko/20060929 SeaMonkey/1.0.5
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Subject: Re: 2.6.19-rc2 - Cable detection problem in pata_amd
References: <453D5067.9070407@lorettotel.net> <1161698939.22348.33.camel@localhost.localdomain>
In-Reply-To: <1161698939.22348.33.camel@localhost.localdomain>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Llu, 2006-10-23 am 18:29 -0500, ysgrifennodd Walt H:
>> On bootup, the pata_amd driver mis-detects the cable connected to the
>> 2nd port on my system as 40 wire and sets UDMA/33 for this drive. Prior
> 
> Can you stick it in bugzilla.kernel.org and assign it to me. Also attach
> an lspci -vxxx. There is a bug or two somewhere in this area still but
> I'm very busy at the moment with other stuff so don't want your report
> to go in one ear and out of the other in a couple of days then get
> forgotten.
> 
> 
> 

Will do.  Bugzilla # is 7411.  Oh, I noticed that I specified kernel
<2.6.19-rc2 in the bugzilla entry, but this occurs in all versions I've
tested, including 2.6.19-rc2.  Thanks,

-Walt

