Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129901AbQLaXUc>; Sun, 31 Dec 2000 18:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130177AbQLaXUW>; Sun, 31 Dec 2000 18:20:22 -0500
Received: from mercury.nildram.co.uk ([195.112.4.37]:40460 "EHLO
	mercury.nildram.co.uk") by vger.kernel.org with ESMTP
	id <S129901AbQLaXUL>; Sun, 31 Dec 2000 18:20:11 -0500
Message-ID: <3A4FB803.20765A02@magenta-netlogic.com>
Date: Sun, 31 Dec 2000 22:49:39 +0000
From: Tony Hoyle <tmh@magenta-netlogic.com>
Organization: Magenta Logic
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test13-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: J Sloan <jjs@pobox.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: tdfx.o and -test13
In-Reply-To: <E14CrCg-00009m-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Possibly something in the auto-dependencies?  Unfortunately I don't have
> > the info files for gcc so
> > I can't work out why the '-include' directive would be
> > overridden/ignored.
> 
> Im wondering if it is make dependant. It seems to be working here

Well I'm on:

make 3.79.1
gcc 2.95.2 20000220
ld 2.10.91
modversions 2.3.23

Tony

-- 
Can't think of a decent signature...

tmh@magenta-netlogic.com		http://www.nothing-on.tv
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
