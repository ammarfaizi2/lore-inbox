Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284619AbSADTvC>; Fri, 4 Jan 2002 14:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288735AbSADTuw>; Fri, 4 Jan 2002 14:50:52 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:37309 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S284619AbSADTup>; Fri, 4 Jan 2002 14:50:45 -0500
Date: 04 Jan 2002 17:39:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8GDPkqCXw-B@khms.westfalen.de>
In-Reply-To: <Pine.LNX.4.33.0201031540390.7309-100000@Appserv.suse.de>
Subject: Re: ISA slot detection on PCI systems?
X-Mailer: CrossPoint v3.12d.kh8 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <8GBXFw6mw-B@khms.westfalen.de> <Pine.LNX.4.33.0201031540390.7309-100000@Appserv.suse.de>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davej@suse.de (Dave Jones)  wrote on 03.01.02 in <Pine.LNX.4.33.0201031540390.7309-100000@Appserv.suse.de>:

> On 3 Jan 2002, Kai Henningsen wrote:
>
> > Now, if we cannot reliably autodetect hardware, we should always make it
> > possible to override this manually, and maybe also inform the user that
> > we're not certain. But that's no excuse not to try to autodetect when the
> > user has *not* overridden us.
>
> Autodetecting non-pnp ISA hardware safely is something of a black art.
> Numerous drivers just hang if you load them and the card isn't present,
> or there's another card which answers on the same port/address.

Well yes, that's why I asked for the override and the warning.

MfG Kai
