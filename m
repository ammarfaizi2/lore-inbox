Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278707AbRJTBGU>; Fri, 19 Oct 2001 21:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278709AbRJTBGL>; Fri, 19 Oct 2001 21:06:11 -0400
Received: from zero.tech9.net ([209.61.188.187]:56850 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S278707AbRJTBF7>;
	Fri, 19 Oct 2001 21:05:59 -0400
Subject: Re: Which is better at vm, and why? 2.2 or 2.4
From: Robert Love <rml@tech9.net>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: "M. Edward Borasky" <znmeb@aracnet.com>,
        "Linux-Kernel@Vger. " "Kernel. Org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20011020003812Z16243-4005+727@humbolt.nl.linux.org>
In-Reply-To: <HBEHIIBBKKNOBLMPKCBBKEOIDOAA.znmeb@aracnet.com> 
	<20011020003812Z16243-4005+727@humbolt.nl.linux.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.18.15.19 (Preview Release)
Date: 19 Oct 2001 21:05:29 -0400
Message-Id: <1003539951.939.3.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-10-19 at 20:38, Daniel Phillips wrote:
> Keep in mind that once you start exposing tuning parameters you tend to get 
> lots of user programs out there that break without the parameters, or if the 
> parameters don't behave the same way across versions.  Official tuning 
> parameters also get in the way of trying out new algorithms, which might not 
> even support the old tweaks, for example.

Agreed.  They also encourage people to write algorithms that are
suboptimal, but perform OK with proper tuning.  This, imho, is the
biggest argument against.

	Robert Love

