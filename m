Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290388AbSAXWYX>; Thu, 24 Jan 2002 17:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290378AbSAXWYN>; Thu, 24 Jan 2002 17:24:13 -0500
Received: from monster.gotadsl.co.uk ([213.208.127.236]:31107 "EHLO
	monster.gotadsl.co.uk") by vger.kernel.org with ESMTP
	id <S290389AbSAXWYE>; Thu, 24 Jan 2002 17:24:04 -0500
Subject: Re: ACPI trouble (Was: Re: [patch] amd athlon cooling on kt266/266a
	chipset)
From: Craig Knox <crg@monster.gotadsl.co.uk>
To: Daniel Nofftz <nofftz@castor.uni-trier.de>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.40.0201242223490.9957-100000@infcip10.uni-trier.de>
In-Reply-To: <Pine.LNX.4.40.0201242223490.9957-100000@infcip10.uni-trier.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 24 Jan 2002 22:24:48 +0000
Message-Id: <1011911089.3572.27.camel@crgs.lowerrd.prv>
Mime-Version: 1.0
X-Scanner: exiscan *16TsEe-000140-00*ztkiIlJ8/aY* (monster.gotadsl.co.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > As to the merits of the amd_disconnect patch that started this thread,
> > under 2.4.18-pre7-acpi, I get an idle CPU temperature of about 48 C.
> > With the amd_disconnect patch, it drops to 32-35 C, wow!  As
> > previously discussed, APM + amd_disconnect on an Athlon does not
> > provide any power savings, one needs ACPI + amd_disconnect.
> 
> ahh ...  anopther "it works"- feedback ... :)

And another.  Dropped my CPU from ~50+C down to 39C (I have a hot
case).  I haven't had any problems but its a headless, no keyboard/mouse
machine.

