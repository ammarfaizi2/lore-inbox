Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262898AbTHZVtD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 17:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262910AbTHZVtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 17:49:03 -0400
Received: from smtp013.mail.yahoo.com ([216.136.173.57]:63754 "HELO
	smtp013.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262898AbTHZVtB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 17:49:01 -0400
Date: Tue, 26 Aug 2003 23:49:01 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <aradorlinux@yahoo.es>
To: =?ISO-8859-15?Q?Ram=F3n?= Rey Vicente____ <retes_simbad@yahoo.es>
Cc: bunk@fs.tum.de, jamagallon@able.es, linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.22 released
Message-Id: <20030826234901.1726adec.aradorlinux@yahoo.es>
In-Reply-To: <1061857293.15168.3.camel@debian>
References: <200308251148.h7PBmU8B027700@hera.kernel.org>
	<20030825132358.GC14108@merlin.emma.line.org>
	<1061818535.1175.27.camel@debian>
	<20030825211307.GA3346@werewolf.able.es>
	<20030825222215.GX7038@fs.tum.de>
	<1061857293.15168.3.camel@debian>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, 26 Aug 2003 02:21:34 +0200 Ramón Rey Vicente____ <retes_simbad@yahoo.es> escribió:

> I think merging ALSA in 2.4 series bring some of the advantages of the
> 2.6 series to the stable kernel, just new drivers with improvements over
> OSS... but I dont think that will help in the switching to 2.6.


I agree with Ramon; OSS doesn't provide drivers for some cards (or they
have really low quality, like the one for my card...). It's not just easing
the migration.

Reasons to include ALSA in 2.4.23:

- Lots of people need it.
- 99.9 % of kernels from vendors have it (they need to include them to
  give good hardware support), which means they have been tested a lot.
- Lots of non-vendor kernels have it (even more testing).
- Some drivers have better quality.
- Low impact: they don't break anything; they're just configurable drivers.
- They're stable.
- They're cool.

Reasons against:
<write here your opinion>

Of course it's ALSA people and Marcello who should speak here not me...

