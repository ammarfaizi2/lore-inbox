Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262420AbSLZEY4>; Wed, 25 Dec 2002 23:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262425AbSLZEY4>; Wed, 25 Dec 2002 23:24:56 -0500
Received: from CPE-203-51-25-222.nsw.bigpond.net.au ([203.51.25.222]:18165
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S262420AbSLZEYz>; Wed, 25 Dec 2002 23:24:55 -0500
Message-ID: <3E0A8685.5CAE1CE0@eyal.emu.id.au>
Date: Thu, 26 Dec 2002 15:33:09 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.20-e1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21pre2aa1: compile error in DAC960.c
References: <20021226010605.GA4223@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As is the case in the last few -aa patches, we still have the
problem in drivers/block/DAC960.c.

I suggest that someone who knows fixes it, or else remove it
from the -aa collection.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
