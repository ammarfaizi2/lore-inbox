Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318243AbSHPH06>; Fri, 16 Aug 2002 03:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318244AbSHPH05>; Fri, 16 Aug 2002 03:26:57 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:11527 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S318243AbSHPH05>;
	Fri, 16 Aug 2002 03:26:57 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200208160730.g7G7UmW39988@saturn.cs.uml.edu>
Subject: Re: [ANNOUNCE] New PC-Speaker driver
To: arodland@noln.com (Andrew Rodland)
Date: Fri, 16 Aug 2002 03:30:48 -0400 (EDT)
Cc: stssppnn@yahoo.com (Stas Sergeev), linux-kernel@vger.kernel.org
In-Reply-To: <20020814184407.4ca9e406.arodland@noln.com> from "Andrew Rodland" at Aug 14, 2002 06:44:07 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Rodland writes:

> I can get some pretty decent sound out of it, but I also get some
> horrible noise. Even if I send the driver a stream of zeroes, as soon
> as it's opened it starts generating some horrible clicks and a
> high-pitched whine.
> 
> Do I blame my motherboard (actually, a laptop)? Is there any way to fix
> this, or at least improve it?

Adding a capacitor is supposed to help a PC speaker
sound driver.

