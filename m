Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284966AbRLUSuT>; Fri, 21 Dec 2001 13:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284973AbRLUSuJ>; Fri, 21 Dec 2001 13:50:09 -0500
Received: from Aniela.EU.ORG ([194.102.102.235]:3333 "EHLO NS1.Aniela.EU.ORG")
	by vger.kernel.org with ESMTP id <S284966AbRLUStv>;
	Fri, 21 Dec 2001 13:49:51 -0500
Date: Fri, 21 Dec 2001 20:49:44 +0200 (EET)
From: <lk@Aniela.EU.ORG>
To: Kent Borg <kentborg@borg.org>
Cc: Mike Harrold <mharrold@cas.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        <nknight@pocketinet.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Changing KB, MB, and GB to KiB, MiB, and GiB in Configure.help.
In-Reply-To: <20011221134150.O3736@borg.org>
Message-ID: <Pine.LNX.4.33.0112212048230.4311-100000@ns1.Aniela.EU.ORG>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Hell, your kernel isn't even going to barf if the "40GB" disk turns
> out to be 39,501,824, or some other less than 40GB-of-any-flavor
> value.  Why do a version of "40GB" that means 40,000,000,000 when
> disks are *never* that size anyway?
>

If you would pay more attention, you can see that on most drives there is
a small note that says: 1MB = 1000000 bytes. This is why the drive
capacity is smaller than the manufacturer says.


> Just because disk manufacturers are, um, creatve, with their marketing
> numbers, do we have to mess with the numbers that are trustworthy?
>
>
> -kb, the Kent who is not so sure he has *ever* seen anything in a
> computer that really was such a big round decimal number, but the Kent
> who sees precise round binary numbers frequently.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

