Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261908AbTAUFDK>; Tue, 21 Jan 2003 00:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261907AbTAUFCJ>; Tue, 21 Jan 2003 00:02:09 -0500
Received: from dhcp34.trinity.linux.conf.au ([130.95.169.34]:3968 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id <S261908AbTAUFCD>; Tue, 21 Jan 2003 00:02:03 -0500
Subject: Re: Spurious 8259A interrupt: IRQ7 ????
From: Alan <alan@lxorguk.ukuu.org.uk>
To: "David D. Hagood" <wowbagger@sktc.net>
Cc: AnonimoVeneziano <voloterreno@tin.it>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <3E2C9623.60709@sktc.net>
References: <3E2C8EFF.6020707@tin.it>  <3E2C9623.60709@sktc.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043119202.13397.8.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 21 Jan 2003 03:20:02 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-21 at 00:36, David D. Hagood wrote:
> AnonimoVeneziano wrote:
> > What does it mean this message?
> > 
> > Of what problem is the signal?
> 
> It is most likely a hardware problem.

It can occur for lots of harmless software reasons too. If you disable
the IRQ on a device just as the PIC sees it you may see this result
for example.

Really for 7/15 on a PC we shouldnt be bugging people

