Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278351AbRJSJzV>; Fri, 19 Oct 2001 05:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278352AbRJSJzK>; Fri, 19 Oct 2001 05:55:10 -0400
Received: from web20201.mail.yahoo.com ([216.136.226.56]:40022 "HELO
	web20201.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S278351AbRJSJy7>; Fri, 19 Oct 2001 05:54:59 -0400
Message-ID: <20011019095532.80319.qmail@web20201.mail.yahoo.com>
Date: Fri, 19 Oct 2001 02:55:32 -0700 (PDT)
From: jimmy <x55k@yahoo.com>
Subject: Re: UNABLE TO BOOT WITH 2nd SCSI DRIVE
To: linux-kernel@vger.kernel.org
In-Reply-To: <20011019100532.A32252@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Russell,

> You've given all the information for the case that
> works, but no information
> about the case that doesn't work.

That is because the server is 8000 miles away from me
(other side of the contient) and I am unable to obtain
all the error messages except the kernel panic (last).

FYI, /dev/sda had ID:0 (old drive) and new drive had
ID:1. I have tried all ID configurations but nothing
worked on 2 drive system.

> What whould be really useful is the above message
> fragment for the case
> where it doesn't boot, particularly which drives
> it's seeing and the
> order it's seeing them.

It might also be helpful to note that the following
error shows for both drives before kernel panic:

"parity error detected in Data-in phase"

So, I assume the order of drives are fine. I am
clueless.

Many thanks.

Jimmy

PS: yahoo is being rejected by your mail server.

__________________________________________________
Do You Yahoo!?
Make a great connection at Yahoo! Personals.
http://personals.yahoo.com
