Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261619AbSJQOLO>; Thu, 17 Oct 2002 10:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261690AbSJQOLO>; Thu, 17 Oct 2002 10:11:14 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:33948 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261619AbSJQOLN>;
	Thu, 17 Oct 2002 10:11:13 -0400
Date: Thu, 17 Oct 2002 15:19:02 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Bryan Whitehead <driver@jpl.nasa.gov>, Mark Cuss <mcuss@cdlsystems.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel reports 4 CPUS instead of 2...
Message-ID: <20021017141902.GB21222@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	Bryan Whitehead <driver@jpl.nasa.gov>,
	Mark Cuss <mcuss@cdlsystems.com>, linux-kernel@vger.kernel.org
References: <3DADF488.1080204@jpl.nasa.gov> <Pine.LNX.3.95.1021017085043.5202A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1021017085043.5202A-100000@chaos.analogic.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 08:56:15AM -0400, Richard B. Johnson wrote:
 > > pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
 >                                                    ^____ hyperstuff
 > 
 > 
 > Your CPU purports to "support" HT, but It doesn't "do" HT!
 > Maybe somebody from Intel can explain, but I heard that they
 > added the HT bit before they implimented hyper-threading.
 > Anyways, maybe you can "turn something on" in the BIOS?

It's HT capable, but lacks the extra sibling found in the
more expensive models.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
