Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316821AbSFJKFx>; Mon, 10 Jun 2002 06:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316823AbSFJKFw>; Mon, 10 Jun 2002 06:05:52 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:15113 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S316821AbSFJKFw>; Mon, 10 Jun 2002 06:05:52 -0400
Date: Sun, 9 Jun 2002 15:26:02 +0100
From: John Levon <movement@marcelothewonderpenguin.com>
To: linux-kernel@vger.kernel.org
Subject: External compilation
Message-ID: <20020609142602.GA77496@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Bendik Singers - Afrotid
X-Toppers: N/A
X-Scanner: exiscan *17HM3J-000Hlj-00*5ZXPEV4PceQ* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is there any good example code for compiling a kernel module
externally, that works for modversions etc. on 2.2, 2.4, and 2.5,
and does the right thing (including Rules.make) ?

I'm having an awful time working out the exact incantations.

On a related note, is it at all possible to make a "mini filesystem"
that will work on 2.2 upwards, so I can avoid proc,sysctl, and ioctl ?

thanks
john

-- 
"Saying that taste is just personal preference is a good way to prevent
disputes. The trouble is, it's not true."
	- Paul Graham
