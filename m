Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129830AbRAaMzO>; Wed, 31 Jan 2001 07:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129784AbRAaMzE>; Wed, 31 Jan 2001 07:55:04 -0500
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:60780 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S129830AbRAaMyw>; Wed, 31 Jan 2001 07:54:52 -0500
Date: Wed, 31 Jan 2001 07:54:27 -0500 (EST)
From: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
To: safemode <safemode@voicenet.com>
cc: David Raufeisen <david@fortyoz.org>, Vojtech Pavlik <vojtech@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: VT82C686A corruption with 2.4.x
In-Reply-To: <3A77DF79.2C1F5A7@voicenet.com>
Message-ID: <Pine.LNX.4.10.10101310752060.155-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From what I gather this chipset on 2.4.x is only stable if you cripple just about everything that makes
> it worth having (udma, 2nd ide channel  etc etc)  ?    does it even work when all that's done now or is
> it fully functional?

it seems to be fully functional for some or most people,
with two, apparently, reporting major problems.

my via (kt133) is flawless in 2.4.1 (a drive on each channel,
udma enabled and in use) and has for all the 2.3's since I got it.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
