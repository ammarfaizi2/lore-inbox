Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129091AbQKWSI3>; Thu, 23 Nov 2000 13:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129097AbQKWSIU>; Thu, 23 Nov 2000 13:08:20 -0500
Received: from 213-120-138-133.btconnect.com ([213.120.138.133]:51976 "EHLO
        penguin.homenet") by vger.kernel.org with ESMTP id <S129091AbQKWSII>;
        Thu, 23 Nov 2000 13:08:08 -0500
Date: Thu, 23 Nov 2000 17:39:28 +0000 (GMT)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andi Kleen <ak@suse.de>, Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: {PATCH} isofs stuff
In-Reply-To: <Pine.LNX.4.10.10011230825380.7992-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0011231738200.1942-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2000, Linus Torvalds wrote:
> To tie two threads together again: the thread about FS corruption is one
> of my main worries right now. Do people who see this happen to use a gcc
> other than egcs-2.91.66? I know Andries apparently has 2.95.2, and he's
> one of the people who have reported corruption problems...

I am using 2.91.66. Ok, I'll get on with testing Al Viro's latest patch
now.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
