Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271257AbRILVkd>; Wed, 12 Sep 2001 17:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271795AbRILVkX>; Wed, 12 Sep 2001 17:40:23 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:9988 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S271257AbRILVkS>;
	Wed, 12 Sep 2001 17:40:18 -0400
Message-ID: <20010911005103.B822@bug.ucw.cz>
Date: Tue, 11 Sep 2001 00:51:03 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Hen, Shmulik" <shmulik.hen@intel.com>,
        "'LKML'" <linux-kernel@vger.kernel.org>
Subject: Re: Developing code for ia64
In-Reply-To: <07E6E3B8C072D211AC4100A0C9C5758302B27313@hasmsx52.iil.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <07E6E3B8C072D211AC4100A0C9C5758302B27313@hasmsx52.iil.intel.com>; from Hen, Shmulik on Mon, Sep 10, 2001 at 02:17:53PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> When developing kernel drivers (module) for ia64, is it necessary to do it
> on an ia64 machine ?
> Our product contains a pre-compiled core object (IP protection :-\ ) and a
> set of wrapper source files, so for dual platform support the tar ball has
> to contain both an ia32 and ia64 versions of the executable. Is there any
> way to get an ia64 compiler (and libs) installed on an ia32 machine and use
> it to get ia64 compatible binaries ?

Yes. That's called cross-compiling.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
