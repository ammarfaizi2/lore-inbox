Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129990AbRAaSNw>; Wed, 31 Jan 2001 13:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130069AbRAaSNl>; Wed, 31 Jan 2001 13:13:41 -0500
Received: from Cantor.suse.de ([213.95.15.193]:13842 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129990AbRAaSN3>;
	Wed, 31 Jan 2001 13:13:29 -0500
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: Looking for comparison data on network stack prowess
In-Reply-To: <E14O11D-0002jM-00@the-village.bc.nu>
From: Andi Kleen <freitag@alancoxonachip.com>
Date: 31 Jan 2001 19:13:14 +0100
In-Reply-To: Alan Cox's message of "31 Jan 2001 18:28:47 +0100"
Message-ID: <oupu26fsi85.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> Someone in .de (Alas I forget their name now) actually did port BSD net/2 to
> Linux.

Matthias Urlichs iirc

He also later implemented a minimal STREAMS clone on Linux for his
ISDN stack. 

[and today Linux is reinventing non shouted streams with netfilter..]

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
