Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270577AbRHNLxW>; Tue, 14 Aug 2001 07:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270586AbRHNLwi>; Tue, 14 Aug 2001 07:52:38 -0400
Received: from alfik.ms.mff.cuni.cz ([195.113.19.71]:33043 "EHLO
	alfik.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S270576AbRHNLvJ>; Tue, 14 Aug 2001 07:51:09 -0400
Date: Sat, 11 Aug 2001 01:36:28 +0000
From: Pavel Machek <pavel@suse.cz>
To: Sergei Haller <Sergei.Haller@math.uni-giessen.de>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
        "'Pavel Machek'" <pavel@suse.cz>, linux-kernel@vger.kernel.org,
        ACPI mailing list <acpi@phobos.fachschaften.tu-muenchen.de>,
        suse-linux@suse.com, suse-linux-e@suse.com
Subject: Re: [Acpi] Re: shutdown on pressing the ATX power button
Message-ID: <20010811013628.F55@toy.ucw.cz>
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDE03A@orsmsx35.jf.intel.com> <Pine.LNX.4.33.0108101103430.785-100000@fb07-calculator.math.uni-giessen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.33.0108101103430.785-100000@fb07-calculator.math.uni-giessen.de>; from Sergei.Haller@math.uni-giessen.de on Fri, Aug 10, 2001 at 11:22:50AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The shutdown script on my system (SuSE 7.2) looks for /proc/apm or
> /proc/sys/acpi and calls 'halt -p' in both casese, else 'halt'.

That's just plain stupid. halt -p should be called. Always.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

