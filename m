Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273883AbRI3SOT>; Sun, 30 Sep 2001 14:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273877AbRI3SOJ>; Sun, 30 Sep 2001 14:14:09 -0400
Received: from [194.213.32.137] ([194.213.32.137]:4868 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S273883AbRI3SNy>;
	Sun, 30 Sep 2001 14:13:54 -0400
Date: Thu, 27 Sep 2001 14:22:51 +0000
From: Pavel Machek <pavel@suse.cz>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Karel Kulhavy <clock@atrey.karlin.mff.cuni.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: Ethernet Error Correction
Message-ID: <20010927142251.A58@toy.ucw.cz>
In-Reply-To: <20010925223437.A21831@atrey.karlin.mff.cuni.cz> <20010926004345.D11046@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010926004345.D11046@mea-ext.zmailer.org>; from matti.aarnio@zmailer.org on Wed, Sep 26, 2001 at 12:43:45AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 	Also, generic PROMISC mode still drops off received frames
> 	with CRC error.

Hmm, sounds good. Someone should create tool for communication over
ethernet with broken crc's. Such communication would be stealth from
normal tcpdump. Do it on your provider's network to escape accounting ;^)

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

