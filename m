Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269100AbRHLLsv>; Sun, 12 Aug 2001 07:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269101AbRHLLsl>; Sun, 12 Aug 2001 07:48:41 -0400
Received: from gannet.scg.man.ac.uk ([130.88.94.110]:58374 "EHLO
	gannet.scg.man.ac.uk") by vger.kernel.org with ESMTP
	id <S269100AbRHLLsa>; Sun, 12 Aug 2001 07:48:30 -0400
Date: Sun, 12 Aug 2001 12:48:40 +0100
From: John Levon <moz@compsoc.man.ac.uk>
To: linux-kernel@vger.kernel.org, sailer@ife.ee.ethz.ch
Subject: Gameport & esssolo1 2.4.8
Message-ID: <20010812124840.A26055@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.19i
X-Url: http://www.movement.uklinux.net/
X-Record: 0898 Dave - Brack Dragon
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


esssolo1 uses register_gameport_port() which requires support for it to
be enabled. Shouldn't there be always-failing register/unregister so I don't have
to compile in input support and joystick support ?

thanks
john

-- 
"In the beginning the Universe was created. This has made a lot
of people very angry and been widely regarded as a bad move."
	- Douglas Adams
