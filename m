Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280343AbRJaRbw>; Wed, 31 Oct 2001 12:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280341AbRJaRbr>; Wed, 31 Oct 2001 12:31:47 -0500
Received: from viper.haque.net ([66.88.179.82]:61894 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S280332AbRJaRaE>;
	Wed, 31 Oct 2001 12:30:04 -0500
Date: Wed, 31 Oct 2001 12:29:22 -0500 (EST)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: Bill Davidsen <davidsen@tmr.com>
cc: <submit-linux-dev-kernel@ns1.yggdrasil.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: fdisk: "File size limit exceeded on fdisk" 2.4.10 to 2.4.13-pre6
In-Reply-To: <Pine.LNX.3.96.1011031121150.24635G-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.33.0110311225200.23299-100000@viper.haque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2001, Bill Davidsen wrote:

> I still am missing this, obviously after I partition the drive I do mke2fs
> so I can use the partition. I don't see what sequence you follow which
> triggers this, can you clarify?

I thought i already sent you (maybe it was to someone else in private
email) the steps/cases that succeed/fail. I'll dig up the email if
not.

What version of glibc are you compiled against? I've got 2.1.3. it could
also be controller specific. I tried it on a HPT366. Haven't tried it on
my onboard (440bx motherboard).

I've only seen one confirmation on the list that duplicates what I'm
seeing.

More info later.

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Developer/Project Lead
   Don't drink and derive." --Unknown          http://www.themes.org/
                                               batmanppc@themes.org
=====================================================================

