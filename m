Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263498AbUJ2WZC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263498AbUJ2WZC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 18:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263523AbUJ2WXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 18:23:48 -0400
Received: from hermes.domdv.de ([193.102.202.1]:42509 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S263557AbUJ2Uhi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 16:37:38 -0400
Message-ID: <4182AA06.5030901@domdv.de>
Date: Fri, 29 Oct 2004 22:37:26 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040918
X-Accept-Language: en-us, en, de
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, typo@shaw.ca,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Paulo Marques <pmarques@grupopie.com>
Subject: Re: Linuxant/Conexant HSF/HCF Modem Drivers Unlocked
References: <1099032721.23148.5.camel@localhost> <418226FA.1030803@grupopie.com> <1099053788.4511.13.camel@localhost> <1099057814.13068.29.camel@localhost.localdomain> <20041029200011.GA18508@redhat.com>
In-Reply-To: <20041029200011.GA18508@redhat.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Fri, Oct 29, 2004 at 02:50:42PM +0100, Alan Cox wrote:
>  > On Gwe, 2004-10-29 at 13:43, Chad Christopher Giffin wrote:
>  > > I still find myself deeply troubled and questioning the legalities of
>  > > using "GPL\0[...]" in the license string of a non-GPL module.  As it is
>  > > a blatant lie.  
>  > 
>  > Oh its almost certainly a criminal offence in the USA - the DMCA for
>  > example. The \0 stupidity checker needs to go into the kernel.
> 
> Copy protection arms-races are always fun. If we did this, no doubt
> some enterprising individual would find that some other value
> also has the same effect.  You need to throw out anything else
> thats non alphanumeric too.  (plus '/' for 'Dual BSD/GPL' and friends)
> 

How about 'GPL\rMy real license'? Which means: yes, you're absolutely right.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
