Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316330AbSEVRiu>; Wed, 22 May 2002 13:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316391AbSEVRit>; Wed, 22 May 2002 13:38:49 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:55288 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S316330AbSEVRir>;
	Wed, 22 May 2002 13:38:47 -0400
Date: Wed, 22 May 2002 10:38:35 -0700
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David Gibson <hermes@gibson.dropbear.id.au>
Subject: Re: Orinoco Wireless driver bugs in 2.5.17
Message-ID: <20020522103834.B10921@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote :
> The Compaq WL1xx orinoco simply doesn't work on 2.4.18 anyway. The older
> driver works, the newer one fails totally.

	Alan,
	Could you be more precise and point out which kernel start
failing ?

	David,
	If I remember properly my debug session with Alan (that was a
long while ago), the COR reset was screwing up the firmware (well, how
many time did I told you to not make it mandatory ?).
	Alan has an old Compaq card (the Intersil PrismII variety, not
the new Lucent one) and his firmware is probably not very fresh.

	Good luck...

	Jean
