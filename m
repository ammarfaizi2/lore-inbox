Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269254AbRHLOnN>; Sun, 12 Aug 2001 10:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269257AbRHLOnD>; Sun, 12 Aug 2001 10:43:03 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:6918 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S269254AbRHLOms>;
	Sun, 12 Aug 2001 10:42:48 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: John Levon <moz@compsoc.man.ac.uk>
cc: linux-kernel@vger.kernel.org, sailer@ife.ee.ethz.ch
Subject: Re: Gameport & esssolo1 2.4.8 
In-Reply-To: Your message of "Sun, 12 Aug 2001 12:48:40 +0100."
             <20010812124840.A26055@compsoc.man.ac.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 13 Aug 2001 00:42:55 +1000
Message-ID: <3592.997627375@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Aug 2001 12:48:40 +0100, 
John Levon <moz@compsoc.man.ac.uk> wrote:
>esssolo1 uses register_gameport_port() which requires support for it to
>be enabled. Shouldn't there be always-failing register/unregister so I don't have
>to compile in input support and joystick support ?

AFAIK this was fixed in the -ac trees some time ago.  I have no idea
why it is not in 2.4.8, maybe Alan Cox is waiting for the input and/or
joystick maintainer to push it.  No, I am not going to do a 2.4.8
version of the fix, that is up to the maintainer.

