Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278068AbRJZJE6>; Fri, 26 Oct 2001 05:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278073AbRJZJEs>; Fri, 26 Oct 2001 05:04:48 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:44805 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S278068AbRJZJEq>;
	Fri, 26 Oct 2001 05:04:46 -0400
Date: Thu, 25 Oct 2001 16:13:31 +0000
From: Pavel Machek <pavel@suse.cz>
To: Marcos Dione <mdione@hal.famaf.unc.edu.ar>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kjournald and disk sleeping
Message-ID: <20011025161330.A38@toy.ucw.cz>
In-Reply-To: <Pine.LNX.4.30.0110221415460.19985-100000@multivac.famaf.unc.edu.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.30.0110221415460.19985-100000@multivac.famaf.unc.edu.ar>; from mdione@hal.famaf.unc.edu.ar on Mon, Oct 22, 2001 at 02:29:23PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 	One thing I thought: how is this supposed to work on laptops? can
> they be suspended? a question related to this one: I also have ACPI turned
> on and APM turned off. how can I switch to stanby states? is there a way?
> again, how does it works on laptops?

I'm working on suspend-to-disk, and suspend-to-ram is mostly working, also.
...
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

