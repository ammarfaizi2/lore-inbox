Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267206AbTBDKVP>; Tue, 4 Feb 2003 05:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267209AbTBDKVP>; Tue, 4 Feb 2003 05:21:15 -0500
Received: from [81.2.122.30] ([81.2.122.30]:60932 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267206AbTBDKVO>;
	Tue, 4 Feb 2003 05:21:14 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302041031.h14AVYcv000642@darkstar.example.net>
Subject: Re: CPU throttling??
To: assembly@gofree.indigo.ie (Seamus)
Date: Tue, 4 Feb 2003 10:31:34 +0000 (GMT)
Cc: andrew.grover@intel.com, davej@codemonkey.org.uk, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <1044354123.17354.23.camel@taherias.sre.tcd.ie> from "Seamus" at Feb 04, 2003 10:22:08 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmmm, it seems most of these apply to mobile processors.
> I'm using AMD 1.4 Athlon Thunderbird on a desktop, as you know my
> processor was the one before release low power AMD XP processors.
> It uses a savage amount of power, and operates well into 60 and 70
> degrees celcius.

Is that the temperature when it's halted, or when it's in use?  I have
never observed the Duron 650 machine that's here get above 30 degrees
C, and the MMX-200 doesn't have a temperature sensor, but I'd estimate
that it never goes above 40.

> One other thing, apart from saving power on CPU and hard-disk (via
> hdparm) is there anything else I can look into ? something worthy
> though.

Well, monitor power saving will save power, but not make the case
temperature drop, which is what I assume you are trying to achieve.

John.
