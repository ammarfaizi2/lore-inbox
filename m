Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282693AbRL0WSa>; Thu, 27 Dec 2001 17:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282877AbRL0WSV>; Thu, 27 Dec 2001 17:18:21 -0500
Received: from bcboy-linux.cisco.com ([171.71.68.225]:17420 "EHLO
	bcboy-linux.cisco.com") by vger.kernel.org with ESMTP
	id <S282693AbRL0WSG>; Thu, 27 Dec 2001 17:18:06 -0500
Date: Thu, 27 Dec 2001 14:17:59 -0800
From: Brian Craft <bcboy@thecraftstudio.com>
To: linux-kernel@vger.kernel.org
Subject: pasting arbitrary input to consoles
Message-ID: <20011227141759.A19460@bcboy-linux.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all -- I'm looking into ways of extending a voice control utility to work on
the consoles. I was hoping there'd be a way to start the app during boot, or
shortly after -- sorta like gpm starts and allows cut and paste in the console.
It would be cool if the typing impaired could still run kudzu or linuxconf at
boot, and have the consoles come up voice-enabled.  

I'm not seeing any easy way to do it, however. Looks like you can only paste to
the consoles from on-screen data (i.e. after first doing a "select" operation
in the manner of gpm).

Another option would be to run a terminal emulator, like screen, that was voice
aware. Can such a program be wedged between the user and the os early during
boot?

All ideas welcome. Please reply to my address, as I'm not subscribed.

b.c.
