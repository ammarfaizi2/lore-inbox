Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267281AbRGKLie>; Wed, 11 Jul 2001 07:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267282AbRGKLiZ>; Wed, 11 Jul 2001 07:38:25 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:19076 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S267281AbRGKLiO>;
	Wed, 11 Jul 2001 07:38:14 -0400
Message-ID: <3B4C3AA4.FEBEF201@mandrakesoft.com>
Date: Wed, 11 Jul 2001 07:38:12 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Harvey <daniel@amristar.com.au>
Cc: linux-laptop@mobilix.org, linux-kernel@vger.kernel.org
Subject: Re: UPDATE: Linux SLOW on Compaq Armada 110 PIII Speedstep
In-Reply-To: <NEBBJDBLILDEDGICHAGAAEPLCFAA.daniel@amristar.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It sounds like you have the same problem I had -- lack of docs for
Intel's SpeedStep means we cannot set/reset the speed.

You need to go into BIOS setup and change your processor speed.

-- 
Jeff Garzik      | A recent study has shown that too much soup
Building 1024    | can cause malaise in laboratory mice.
MandrakeSoft     |
