Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280388AbRKNJco>; Wed, 14 Nov 2001 04:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280382AbRKNJce>; Wed, 14 Nov 2001 04:32:34 -0500
Received: from gonzo.szczepanek.de ([131.220.156.2]:41122 "HELO
	mail.szczepanek.de") by vger.kernel.org with SMTP
	id <S280365AbRKNJcY>; Wed, 14 Nov 2001 04:32:24 -0500
Subject: Problem with double characters with Fujitsu-Siemens
	Keybird-Wireless Keyboard (2.4.4)
From: Torge Szczepanek <tsml@szczepanek.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 14 Nov 2001 10:32:16 +0100
Message-Id: <1005730337.1038.7.camel@cygnus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have some strange problems with a new wireless keyboard from
Fujitsu-Siemens (Keybird Wireless). It works fine under other OSes, but
in my Linux-Console some special keys (like Cursor up/down/left/right
Page up/down) are repeated. I receive two "characters" instead of one. 

Under XFree86 the problem extends: Now all characters are repeated!

Sorry for posting this directly to the linux-kernel maillinglist, but I
don't think this is a problem with my hardware, because under other OS
it works fine.

I also tried to set various keyboard repeat rates, but nothing changed.

I am using Linux 2.4.4.

Is this problem already known? 


