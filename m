Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750903AbVLBSnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbVLBSnj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 13:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbVLBSnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 13:43:39 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:11243 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750900AbVLBSni convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 13:43:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KqWMs70U5oTBtByaH9l8PFcumNtbl96sxYTmERLJoIpmNXw06OJsLM8Q9IDMwqtykWKmB8O/BnjbK4rlgQTpSsmIqf+QMX6lDfqcOk5U57WQrNitQ5B5VQt/oE+ks5t3Rn3exQcWXhABlwvultz7V32LNBa6Mbi7JDgFe3fRn2g=
Message-ID: <9a8748490512021043o4c27a7c1o8e2cad0362a33dc6@mail.gmail.com>
Date: Fri, 2 Dec 2005 19:43:37 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Ryan Richter <ryan@tau.solarneutrino.net>
Subject: Re: Fw: crash on x86_64 - mm related?
Cc: Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       Kai Makisara <Kai.Makisara@kolumbus.fi>, Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <20051202180326.GB7634@tau.solarneutrino.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051129092432.0f5742f0.akpm@osdl.org>
	 <Pine.LNX.4.63.0512012040390.5777@kai.makisara.local>
	 <Pine.LNX.4.64.0512011136000.3099@g5.osdl.org>
	 <20051201195657.GB7236@tau.solarneutrino.net>
	 <Pine.LNX.4.61.0512012008420.28450@goblin.wat.veritas.com>
	 <20051202180326.GB7634@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/05, Ryan Richter <ryan@tau.solarneutrino.net> wrote:
[snip]
>
> Could someone please tell me exactly which patches I should include in
> the kernel I will boot tomorrow?  I haven't played with -rc for ages, so
> I'm no longer sure which kernel I should start with (2.6.14 or
> 2.6.14.3?).  Are the MPT-fusion performance fix patches in -rc4, or if
> not will they still apply?
>
The -rc patches apply to the base x.y.z kernel - in this case 2.6.14
For more info, read Documentation/applying-patches.txt in a recent
kernel source (or use this link:
http://sosdg.org/~coywolf/lxr/source/Documentation/applying-patches.txt
)


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
