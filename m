Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131044AbQKPQqm>; Thu, 16 Nov 2000 11:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130540AbQKPQqc>; Thu, 16 Nov 2000 11:46:32 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:63762 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S131148AbQKPQqM>;
	Thu, 16 Nov 2000 11:46:12 -0500
Message-ID: <3A14082F.2BF01D85@mandrakesoft.com>
Date: Thu, 16 Nov 2000 11:15:43 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: David Woodhouse <dwmw2@infradead.org>, David Hinds <dhinds@valinux.com>,
        torvalds@transmeta.com, tytso@valinux.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia event thread. (fwd)
In-Reply-To: <E13wRag-0007ym-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> the modules from David Hinds and Linus
> pcmcia are not 100% binary compatible for all cases.

What cases are these?

David's been pretty good about putting 2.4.x support into pcmcia_cs
package...

-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
