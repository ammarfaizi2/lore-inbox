Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262997AbREWHdn>; Wed, 23 May 2001 03:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262999AbREWHdd>; Wed, 23 May 2001 03:33:33 -0400
Received: from highland.isltd.insignia.com ([195.217.222.20]:55055 "EHLO
	highland.isltd.insignia.com") by vger.kernel.org with ESMTP
	id <S262997AbREWHd2>; Wed, 23 May 2001 03:33:28 -0400
Message-ID: <3B0B6808.F42AF166@insignia.com>
Date: Wed, 23 May 2001 08:34:32 +0100
From: Stephen Thomas <stephen.thomas@insignia.com>
Organization: Insignia Solutions
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-ac13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: Gameport analog joystick broken in 2.4.4-ac13
In-Reply-To: <E152Kbd-0002a1-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> No joystick changes in 12->13. Is the fail repeatable ?

It seems not.  It failed on two successive boots last night, but
this morning I booted the machine 3 times and the joystick was
recognized just fine each time.

Flaky hardware?  The plug is screwed in and the joystick works
just fine (as far as I can tell) when in use.

I'll continue to keep an eye on this.

Stephen
