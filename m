Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275017AbRIYO1N>; Tue, 25 Sep 2001 10:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275018AbRIYO1C>; Tue, 25 Sep 2001 10:27:02 -0400
Received: from mail.altus.de ([195.124.129.2]:10237 "EHLO imail.altus.de")
	by vger.kernel.org with ESMTP id <S275017AbRIYO0v>;
	Tue, 25 Sep 2001 10:26:51 -0400
Message-ID: <3BB09442.B3D099F7@altus.de>
Date: Tue, 25 Sep 2001 16:27:14 +0200
From: Juri Haberland <haberland@altus.de>
Organization: Altus Analytics AG
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-xfs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Luis Fernando Pias de Castro <luis@cs.sunysb.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10 power management lockup
In-Reply-To: <20010924220433.29ED8763@localhost.blazeconnect.net>
		<3BB03A41.4B64F831@altus.de> <87g09bicga.fsf@lfmobile.lmc.cs.sunysb.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luis Fernando Pias de Castro wrote:
> 
> Probably not much interesting, but I have an i8000 working fine
> (suspending when display is closed and all) with 2.4.8-ac11 (and
> several others prior to this) as long as I never load the agpgart
> module.

Yes, that's another issue where I hope to find the time to provide some
useful debuging info to the relevant people...

Juri

-- 
  If each of us have one object, and we exchange them,
     then each of us still has one object.
  If each of us have one idea,   and we exchange them,
     then each of us now has two ideas.
