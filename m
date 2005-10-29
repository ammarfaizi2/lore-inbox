Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbVJ2Uom@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbVJ2Uom (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 16:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbVJ2Uom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 16:44:42 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:12732 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932110AbVJ2Uom convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 16:44:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pMpG979S0f9gSERyHHmgc0t0wOWBZIIj7KTkfzSSE+n1h7NsdKZcWIeP1mnPfaOvUfbdU108rM3jAyyHw+4TsiO6gOWOV8QlCcX2GLH9yjFXnIHZlm7I6pKF7TDjZX9DYGNTfmn7Jzyx9Qq5TFaYiQf/ZY455Kk6BL0YoZIYZh4=
Message-ID: <8355959a0510291344o663a2904nd828c90812f4ffb5@mail.gmail.com>
Date: Sun, 30 Oct 2005 02:14:39 +0530
From: Akula2 <akula2.shark@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: New (now current development process)
In-Reply-To: <Pine.LNX.4.64.0510291314100.3348@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com>
	 <12c511ca0510291157u5557b6b1x85a47311f0e16436@mail.gmail.com>
	 <20051029195115.GD14039@flint.arm.linux.org.uk>
	 <Pine.LNX.4.64.0510291314100.3348@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is my first mail to the Kernel tree:-

> Everything said, I think 2.6.13->14 worked well enough, even if it's hard
> to say how well a process works after one release. Considering that 2.6.13
> had the painful PCI changes (you may not have noticed too much, since they
> were x86 only) and there were some potentially painful SCSI changes in the
> .14 early merges, so it's not like 13->14 was an "easy" release - so the
> process certainly _seems_ to be workable.

Will you please throw more light on the *painful* PCI & SCSI changees?


> I don't think anybody has been really unhappy with this approach? Hmm?

honestly, I did download 14 yesterday and made the kernel ready to
compile. today I've seen 14git1 patch! Am trying to understand why is
it this kind of kernel development model...

thanks,
Akula
