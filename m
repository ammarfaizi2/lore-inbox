Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbQKQOLc>; Fri, 17 Nov 2000 09:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129440AbQKQOLX>; Fri, 17 Nov 2000 09:11:23 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:39174 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129383AbQKQOLM>;
	Fri, 17 Nov 2000 09:11:12 -0500
Message-ID: <3A15354B.4736A19@mandrakesoft.com>
Date: Fri, 17 Nov 2000 08:40:27 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Christoph Rohland <cr@sap.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Tigran Aivazian <tigran@veritas.com>,
        Mikael Pettersson <mikpe@csd.uu.se>, Jordan <ledzep37@home.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Error in x86 CPU capabilities starting with test5/6
In-Reply-To: <E13wkLK-0000bP-00@the-village.bc.nu> <qwwpujuvk1s.fsf@sap.com> <3A152DC1.21B35324@mandrakesoft.com> <qwwlmuivio0.fsf@sap.com> <20001117143150.A6832@gruyere.muc.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> No it would not. Often you want cycle accurate couting for profiling
> purposes.

Isn't that why /dev/cpu/%d/msr exists?

-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
