Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133081AbRDRLKa>; Wed, 18 Apr 2001 07:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133082AbRDRLKU>; Wed, 18 Apr 2001 07:10:20 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:42145 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S133081AbRDRLKC>;
	Wed, 18 Apr 2001 07:10:02 -0400
Message-ID: <3ADD7606.5763D076@mandrakesoft.com>
Date: Wed, 18 Apr 2001 07:09:58 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-19mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dennis Bjorklund <db@zigo.dhs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: D-Link DFE-550TX
In-Reply-To: <Pine.LNX.4.30.0104181253040.6746-100000@merlin.zigo.dhs.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dennis Bjorklund wrote:
> It seems to have some good qualities. It says that it comes with drivers
> for linux, but i'm afraid that it might be a precompiled kernel module?
> And then the card is useless to me. I don't even know what chip is used,
> since I can't find that on the webpage:

It uses the "sundance" driver, and it should work fine in 2.4 after you
apply some fixes from me :)

-- 
Jeff Garzik       | "The universe is like a safe to which there is a
Building 1024     |  combination -- but the combination is locked up
MandrakeSoft      |  in the safe."    -- Peter DeVries
