Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287283AbSBGK7V>; Thu, 7 Feb 2002 05:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287287AbSBGK7L>; Thu, 7 Feb 2002 05:59:11 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:20740 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287283AbSBGK67>; Thu, 7 Feb 2002 05:58:59 -0500
Subject: Re: want opinions on possible glitch in 2.4 network error reporting
To: ionut@cs.columbia.edu (Ion Badulescu)
Date: Thu, 7 Feb 2002 11:11:55 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org,
        cfriesen@nortelnetworks.com (Chris Friesen)
In-Reply-To: <Pine.LNX.4.44.0202062131290.4832-100000@age.cs.columbia.edu> from "Ion Badulescu" at Feb 06, 2002 09:54:45 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16YmT5-0008LS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Wrong. man ping. ping -f doesn't do what you apparently think it does.
> 
> strace ping, you'll see it doing a 
> 	setsockopt(7, SOL_SOCKET, SO_SNDTIMEO, [1], 8) = 0
> 
> on its socket.

Read the ping manual page. Then when you understand what ping -f does 
come back and have a useful conversation.
