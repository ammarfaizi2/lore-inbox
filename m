Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131662AbRDCMcK>; Tue, 3 Apr 2001 08:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131654AbRDCMbz>; Tue, 3 Apr 2001 08:31:55 -0400
Received: from [195.63.194.11] ([195.63.194.11]:21777 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S131658AbRDCM3M>; Tue, 3 Apr 2001 08:29:12 -0400
Message-ID: <3AC9BEEF.A2EC0CA@evision-ventures.com>
Date: Tue, 03 Apr 2001 14:15:43 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andries.Brouwer@cwi.nl,
        torvalds@transmeta.com, hpa@transmeta.com,
        linux-kernel@vger.kernel.org, tytso@MIT.EDU
Subject: Re: Larger dev_t
In-Reply-To: <20010403120911.B4561@nightmaster.csn.tu-chemnitz.de> <E14kPZz-0007tk-00@the-village.bc.nu> <20010403142024.Z8155@nightmaster.csn.tu-chemnitz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> One thing I certainly miss: DevFS is not mandatory (yet).

That's "only" due to the fact that DevFS is an insanely racy and
instable
piece of CRAP. I'm unhappy it's there anyway...
