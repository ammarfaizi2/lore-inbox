Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264549AbTLMK2v (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 05:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264553AbTLMK2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 05:28:50 -0500
Received: from mail.gmx.de ([213.165.64.20]:22160 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264549AbTLMK2t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 05:28:49 -0500
Date: Sat, 13 Dec 2003 11:28:47 +0100 (MET)
From: "Svetoslav Slavtchev" <svetljo@gmx.de>
To: John Bradford <john@grabjohn.com>
Cc: opengeometry@yahoo.ca, linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <200312131020.hBDAKFji000447@81-2-122-30.bradfords.org.uk>
Subject: Re: Multiple keyboard/monitor vs linux-2.6?
X-Priority: 3 (Normal)
X-Authenticated: #20183004
Message-ID: <2497.1071311327@www59.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Quote from William Park <opengeometry@yahoo.ca>:
> > On Sat, Dec 13, 2003 at 12:09:05AM +0100, Svetoslav Slavtchev wrote:
> > > if you just want muliple X users bruby/ ruby should work as stable as
> > > 2.4 /2.6 (works at least for 20-25 people i helped, reading the howto
> > > and getting it up),
> > > 
> > > but if you want multiple virtual terminals, you'll have to experiment
> :-)
> > > and read a lot the linuxconsole ml, as it's not yet documented 
> > 
> > Multiple X users (via xdm login) is what I'm looking for.  X-terminal is
> > the canonical answer.  In the light of recent development in PXE support
> > which effectively eliminated third-party packages like Etherboot,
> > Netboot, Rom-a-matic, and LTSP,  I was wondering if it's possible to go
> > the next logical step and eliminate motherboard/case as well.
> > 
> > This would be ideal for home market, where you want multiple users (ie.
> > kids) but with only one PC.  Sell it as "Linux Mainframe"... :-)
> 
> Search the archives - this comes up every few months on LKML.
> 
> John.
> 

with the small difference that now it's doable,
and previously mostly impossible

/* ya i know that Miguel solution exist quite a long time
 * already, but it's a bit hard to use it on systems with more
 * then 2 users and configuring the input devices is not easy,
 * optimal, and tere is no way to get multi-user virtual consoles
 * 
 * ruby doesn't have this issues
 */

best,

svetljo

-- 
+++ GMX - die erste Adresse für Mail, Message, More +++
Neu: Preissenkung für MMS und FreeMMS! http://www.gmx.net


