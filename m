Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129744AbQK3E65>; Wed, 29 Nov 2000 23:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129983AbQK3E6h>; Wed, 29 Nov 2000 23:58:37 -0500
Received: from kiln.isn.net ([198.167.161.1]:8264 "EHLO kiln.isn.net")
        by vger.kernel.org with ESMTP id <S129744AbQK3E6e>;
        Wed, 29 Nov 2000 23:58:34 -0500
Message-ID: <3A25C57C.4F1389A2@isn.net>
Date: Wed, 29 Nov 2000 23:11:56 -0400
From: "A. A. Reese" <aareese@isn.net>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Patrick Mochel <mochel@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Acpi] linux-test12-pre3 fails to compile in acpi.c]
In-Reply-To: <Pine.LNX.4.10.10011291803330.18505-100000@nobelium.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel wrote:
> 
> Hmm...I tried it a few times, and I could not get it to fail.  This is
> what I did:
Success!
rm -rf linux-2.4
Started over with my original linux-2.4.0-test10.bz2, patched it up and
all was fine.
Perhaps I experienced some of the fs corruption that has been floating
around.

Linux support never will cease to amaze me.
Thanks!
Garst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
