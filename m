Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263027AbREWJW1>; Wed, 23 May 2001 05:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263025AbREWJWR>; Wed, 23 May 2001 05:22:17 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:36616 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263026AbREWJWA>; Wed, 23 May 2001 05:22:00 -0400
Subject: Re: Gameport analog joystick broken in 2.4.4-ac13
To: stephen.thomas@insignia.com (Stephen Thomas)
Date: Wed, 23 May 2001 10:19:25 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), vojtech@suse.cz,
        linux-kernel@vger.kernel.org
In-Reply-To: <3B0B6808.F42AF166@insignia.com> from "Stephen Thomas" at May 23, 2001 08:34:32 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E152Une-0003AZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It seems not.  It failed on two successive boots last night, but
> this morning I booted the machine 3 times and the joystick was
> recognized just fine each time.
> 
> Flaky hardware?  The plug is screwed in and the joystick works
> just fine (as far as I can tell) when in use.
> 
> I'll continue to keep an eye on this.

Can you compare /proc/ioports between the two 

