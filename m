Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265395AbTFMNr1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 09:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265396AbTFMNr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 09:47:27 -0400
Received: from web12901.mail.yahoo.com ([216.136.174.68]:47732 "HELO
	web12901.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265395AbTFMNrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 09:47:25 -0400
Message-ID: <20030613140111.34979.qmail@web12901.mail.yahoo.com>
Date: Fri, 13 Jun 2003 16:01:11 +0200 (CEST)
From: =?iso-8859-1?q?Terje=20F=E5berg?= <terje_fb@yahoo.no>
Subject: Re: Real multi-user linux
To: John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200306130813.h5D8DeA8000540@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford <john@grabjohn.com> skrev:

> This idea has come up before, have a look at:
>  http://marc.theaimsgroup.com/?.....

Thank you for providing these references.  Especially
the first thread discusses some thoughts I had, too. 

To summarize: People have thought about of one linux
box directly supporting multiple (X-)consoles before.
But this is not possible as of now, because X would
have to be told to stop switching consoles and because
the kernel cannot activate more than one console at
one time. Additionately, multiple video cards may
require mappings into the same memory area for certain
functions. Some people have started to work on  a
solution, but these projects were orphaned. 

My motivation is simply a private one.  I have a
P3-866 with 1.5G RAM and a scsi raid here which serves
its own console and an old P133 as X terminal.
Although this machine is already some kind of
outdated, it has plenty of power to serve two users
with one KDE session each. 

I started to think about this, because the P133 died
away due to a failing processor fan. Although
replacing the whole machine with a similar one
probably is cheaper than a good usb keyboard and
mouse, it is also a question of comfort. No waiting
for the terminal to boot up, no double administration,
less power consumption, less space needed and so on. 

Although I have some C/C++ expirience, I have
absolutely no clues about kernel and or X internals,
so I guess I have to forget this for now. 

Regards, 
Terje


______________________________________________________
Få den nye Yahoo! Messenger på http://no.messenger.yahoo.com/
Nye ikoner og bakgrunner, webkamera med superkvalitet og dobbelt så morsom
