Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129845AbRB0UaN>; Tue, 27 Feb 2001 15:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129851AbRB0UaD>; Tue, 27 Feb 2001 15:30:03 -0500
Received: from [194.213.32.137] ([194.213.32.137]:2052 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129848AbRB0U3w>;
	Tue, 27 Feb 2001 15:29:52 -0500
Message-ID: <20010227011325.A1798@bug.ucw.cz>
Date: Tue, 27 Feb 2001 01:13:25 +0100
From: Pavel Machek <pavel@suse.cz>
To: Oswald Buddenhagen <ob6@inf.tu-dresden.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] quick reboot on i386
In-Reply-To: <20010226124931.A20095@ugly.wh8.tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010226124931.A20095@ugly.wh8.tu-dresden.de>; from Oswald Buddenhagen on Mon, Feb 26, 2001 at 12:49:31PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> remember quarterdeck's quickreboot from "good" (*cough*) old D{o|O}S
> days? here it is for linux! it's only of limited use, especially
> in it's current state, but some people might find it useful.

Hmm, I'm probably going to apply this one, as I hate behaviour of my
bios: if you power off during POST it will not come up next time
asking for you to adjust CPU frequency.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
