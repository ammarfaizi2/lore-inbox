Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129685AbRBFRuH>; Tue, 6 Feb 2001 12:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129671AbRBFRt4>; Tue, 6 Feb 2001 12:49:56 -0500
Received: from [194.213.32.137] ([194.213.32.137]:3844 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129586AbRBFRtq>;
	Tue, 6 Feb 2001 12:49:46 -0500
Message-ID: <20010206164248.M1412@bug.ucw.cz>
Date: Tue, 6 Feb 2001 16:42:48 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Better battery info/status files
In-Reply-To: <20010202155341.A149@bug.ucw.cz> <200102032322.f13NMZp438329@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <200102032322.f13NMZp438329@saturn.cs.uml.edu>; from Albert D. Cahalan on Sat, Feb 03, 2001 at 06:22:34PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This fixes units, and makes format tag: value. Please apply.
> 
> The units seem to vary. I suggest using fundamental SI units.
> That would be meters, kilograms, seconds, and maybe a very
> few others -- my memory fails me on this.

No!

volt = m^2 g sec^-3 A^-1

I do not want to learn that my battery has voltage of 

10.8 m^2 g sec^-3 A^-1

!

								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
