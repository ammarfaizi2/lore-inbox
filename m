Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267360AbUGNKkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267360AbUGNKkb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 06:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267361AbUGNKka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 06:40:30 -0400
Received: from mailrelay.nefonline.de ([212.114.153.196]:45796 "EHLO
	mailrelay1.nefonline.de") by vger.kernel.org with ESMTP
	id S267360AbUGNKkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 06:40:22 -0400
Date: Wed, 14 Jul 2004 12:40:08 +0200
From: Hermann Gottschalk <hg@ostc.de>
To: Roger Luethi <rl@hellgate.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange Network behaviour
Message-ID: <20040714104008.GA12323@ostc.de>
References: <20040702153028.GD15170@ostc.de> <20040704164654.GA18688@outpost.ds9a.nl> <20040714080036.GC11178@ostc.de> <20040714090208.GA2274@k3.hellgate.ch> <20040714102849.GD11727@ostc.de> <20040714103311.GA5411@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040714103311.GA5411@k3.hellgate.ch>
User-Agent: Mutt/1.4.1i
X-PGP-Key: 1024D/0B2D8EEA 2004-06-07 Hermann Gottschalk (OSTC) <hg@ostc.de>
X-PGP-Fingerprint: 9A36 D20E B7FB BE5D 11DB  3006 3ADA D083 0B2D 8EEA
X-Operating-System: Linux 2.4.21-231-default
X-message-flag: Please do NOT send HTML e-mail or MS Word attachments - use plain text instead
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 12:33:12PM +0200, Roger Luethi wrote:
> On Wed, 14 Jul 2004 12:28:49 +0200, Hermann Gottschalk wrote:
> > > If you set debug in via-rhine to 3, you'll get a more interesting
> > > log. Does booting with noacpi help at all?
> > 
> > I will try noapic.
> 
> noapic != noacpi
> Both ACPI and APIC have been known to cause problems, though.

noacpi doesn't exist as kernel-parameter
(/usr/src/linux/Documentation/kernel-parameters.txt)

-- 
  ___  ___ _____ ___    ___       _    _  _
 / _ \/ __|_   _/ __|  / __|_ __ | |__| || |
| (_) \__ \ | || (__  | (_ | '  \| '_ \ __ |
 \___/|___/ |_| \___|  \___|_|_|_|_.__/_||_|
----------------------------------------------
 OSTC Open Source Training and Consulting GmbH
 Hermann Gottschalk  eMail:         hg@ostc.de
 Dipl.-Phys. Univ.   Tel:   +49 911-18 06 25 6
                     Mobil: +49 173-36 00 68 0
 Delsenbachweg 32    Fax:   +49 911-18 06 27 7
 90425 Nürnberg      Web:   http://www.ostc.de
----------------------------------------------
            PGP-Key: 0x0B2D8EEA 
    No HTML-Mails; 72 Characters per line
