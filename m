Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262080AbSJZK0Y>; Sat, 26 Oct 2002 06:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262055AbSJZKY5>; Sat, 26 Oct 2002 06:24:57 -0400
Received: from smtp.kolej.mff.cuni.cz ([195.113.25.225]:33548 "EHLO
	smtp.kolej.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262046AbSJZKYk>; Sat, 26 Oct 2002 06:24:40 -0400
X-Envelope-From: pavel@bug.ucw.cz
Date: Mon, 21 Oct 2002 11:21:27 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andi Kleen <ak@suse.de>
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>,
       "David S. Miller" <davem@redhat.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
Subject: Re: [PATCH] fixes for building kernel using Intel compiler
Message-ID: <20021021092127.GC2876@elf.ucw.cz>
References: <F2DBA543B89AD51184B600508B68D4000E6ADE72@fmsmsx103.fm.intel.com> <20021019042929.A18070@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021019042929.A18070@wotan.suse.de>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> BTW do you have any benchmark / code size results to share with 
> Intel compiler vs gcc 3.2 ? How much does it give ?

Also does it work properly after compiling with icc? Working well with
second compiler would be pretty good news for both kernel and icc...

								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
