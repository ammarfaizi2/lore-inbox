Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262803AbSJWDiP>; Tue, 22 Oct 2002 23:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262805AbSJWDiP>; Tue, 22 Oct 2002 23:38:15 -0400
Received: from magic.adaptec.com ([208.236.45.80]:57850 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S262803AbSJWDiO>; Tue, 22 Oct 2002 23:38:14 -0400
Date: Tue, 22 Oct 2002 21:44:11 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: AIC7xxx driver build failure
Message-ID: <193030000.1035344651@aslan.btc.adaptec.com>
In-Reply-To: <1035202558.27309.64.camel@irongate.swansea.linux.org.uk>
References: <15794.7193.525850.601506@milikk.co.intel.com>
 	<671452704.1035095402@aslan.scsiguy.com>
 <1035202558.27309.64.camel@irongate.swansea.linux.org.uk>
X-Mailer: Mulberry/3.0.0a4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, 2002-10-20 at 07:30, Justin T. Gibbs wrote:
>> > The AIC 7xxx driver fails to build because the Makefile fails to
>> > specify the correct include path to aicasm.
>> > 
>> > Justin, are you getting this?
>> 
>> No, because this bug doesn't exist in the latest version of the driver
>> in my tree or the last set of patches I sent to Linus (a month ago??).
> 
> Care to send me the stuff Linus has dropped ?

I will send a new driver update as soon as our internal testing
of the latest aic7xxx and aic79xx drivers has been completed.
Since this new version adds Domain Validation, it will be a little
bit. The last version I sent to Linus, which were cut before
for the recent queue depth API change, can be found here:

http://people.FreeBSD.org/~gibbs/linux/linux-2.5-aic79xxx.tar.gz

--
Justin

