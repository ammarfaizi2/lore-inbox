Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263904AbUD0JB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263904AbUD0JB3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 05:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263917AbUD0JB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 05:01:29 -0400
Received: from mail.tpgi.com.au ([203.12.160.58]:1982 "EHLO mail2.tpgi.com.au")
	by vger.kernel.org with ESMTP id S263904AbUD0JB2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 05:01:28 -0400
Date: Tue, 27 Apr 2004 18:56:07 +1000
From: "Nigel Cunningham" <ncunningham@linuxmail.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       "Pavel Machek" <pavel@suse.cz>
Subject: Re: Bug#234976: kernel-source-2.6.4: Software Suspend doesn't work
Cc: "Herbert Xu" <herbert@gondor.apana.org.au>,
       "Roland Stigge" <stigge@antcom.de>, 234976@bugs.debian.org,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Reply-To: ncunningham@linuxmail.com
References: <1080310299.2108.10.camel@atari.stigge.org>  <20040326142617.GA291@elf.ucw.cz>  <1080315725.2951.10.camel@atari.stigge.org>  <20040326155315.GD291@elf.ucw.cz>  <1080317555.12244.5.camel@atari.stigge.org>  <20040326161717.GE291@elf.ucw.cz>  <1080325072.2112.89.camel@atari.stigge.org>  <20040426094834.GA4901@gondor.apana.org.au>  <20040426104015.GA5772@gondor.apana.org.au>  <opr6193np1ruvnp2@laptop-linux.wpcb.org.au>  <20040426131152.GN2595@openzaurus.ucw.cz> <1083048985.12517.21.camel@gaston>
Content-Type: text/plain; format=flowed; delsp=yes; charset=us-ascii
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <opr63xrt1vruvnp2@laptop-linux.wpcb.org.au>
In-Reply-To: <1083048985.12517.21.camel@gaston>
User-Agent: Opera M2/7.50 (Linux, build 663)
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 27 Apr 2004 16:56:25 +1000, Benjamin Herrenschmidt  
<benh@kernel.crashing.org> wrote:

>> re nuanced test? Better still,
>>
>> Test should still be there. Switching to temporary page tables
>> seems to be tbe solution.
>
> This is close to the problem I talked about when that PPC version
> appeared, which is why, at least on resume, I run everything with
> MMU off in the patch I proposed :)
>
> (BTW, Nigel, did you merge the PPC support at all in swsusp2 ?)

Yes. I have a recent patch still to apply, but I did put previous patches  
in.

Regards,

Nigel


-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614, Australia.
+61 (2) 6251 7727 (wk)
