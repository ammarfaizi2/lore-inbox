Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284953AbRLUSmJ>; Fri, 21 Dec 2001 13:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284955AbRLUSl6>; Fri, 21 Dec 2001 13:41:58 -0500
Received: from borg.org ([208.218.135.231]:49929 "HELO borg.org")
	by vger.kernel.org with SMTP id <S284953AbRLUSlv>;
	Fri, 21 Dec 2001 13:41:51 -0500
Date: Fri, 21 Dec 2001 13:41:50 -0500
From: Kent Borg <kentborg@borg.org>
To: Mike Harrold <mharrold@cas.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, nknight@pocketinet.com,
        linux-kernel@vger.kernel.org
Subject: Re: Changing KB, MB, and GB to KiB, MiB, and GiB in Configure.help.
Message-ID: <20011221134150.O3736@borg.org>
In-Reply-To: <E16HT1H-0000o0-00@the-village.bc.nu> <200112211750.MAA06283@mah21awu.cas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200112211750.MAA06283@mah21awu.cas.org>; from mharrold@cas.org on Fri, Dec 21, 2001 at 12:50:55PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2001 at 12:50:55PM -0500, Mike Harrold wrote:
> That isn't quite so important. My kernel isn't likely to f*ck up when
> a 40GB HD = 40,000,000,000. I'm sure it will die quite painfully with
> RAM chips that are not powers of 2.

Hell, your kernel isn't even going to barf if the "40GB" disk turns
out to be 39,501,824, or some other less than 40GB-of-any-flavor
value.  Why do a version of "40GB" that means 40,000,000,000 when
disks are *never* that size anyway?

Just because disk manufacturers are, um, creatve, with their marketing
numbers, do we have to mess with the numbers that are trustworthy?


-kb, the Kent who is not so sure he has *ever* seen anything in a
computer that really was such a big round decimal number, but the Kent
who sees precise round binary numbers frequently.
