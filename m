Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263299AbTIHRYH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 13:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263376AbTIHRYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 13:24:07 -0400
Received: from mail.hometree.net ([212.34.184.41]:49318 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP id S263299AbTIHRYE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 13:24:04 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: Hardware supported by the kernel
Date: Mon, 8 Sep 2003 17:23:52 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <bjidv8$9cl$1@tangens.hometree.net>
References: <3F59DF81.8000407@bluewin.ch> <20030906134029.GE69@DervishD> <20030907223258.GE28927@redhat.com> <20030908092952.GA51@DervishD> <20030908095357.GD10358@redhat.com>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1063041832 9621 212.34.184.4 (8 Sep 2003 17:23:52 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Mon, 8 Sep 2003 17:23:52 +0000 (UTC)
X-Copyright: (C) 1996-2003 Henning Schmiedehausen
X-No-Archive: yes
User-Agent: nn/6.6.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> writes:

>Matrox - Not exactly a speed demon any more in the 3d market. Open
>         drivers though. Not sure about Parhelia.

LOL. Buying a G550 was the biggest mistake I ever did. DVI-D support
only with a binary only module and still a heavy bug in it (basically
it takes a 90 second break when starting X).

IMHO The best supported 3D gfx chip for Linux comes from nVidia. Yes,
it is binary only and people invented the "TAINTED" flag to report
this, but it is a fast, vendor-supported driver which works fine in
99% of all configurations which are one gfx board, one or two
displays. (yes, I know it has some issues with power management on
laptops). But all other vendors are worse and nvidia at least cares.

If you just want 2D on an VGA, you can basically buy anything starting
at $19.

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen          INTERMETA GmbH
hps@intermeta.de        +49 9131 50 654 0   http://www.intermeta.de/

Java, perl, Solaris, Linux, xSP Consulting, Web Services 
freelance consultant -- Jakarta Turbine Development  -- hero for hire

"Dominate!! Dominate!! Eat your young and aggregate! I have grotty silicon!" 
      -- AOL CD when played backwards  (User Friendly - 200-10-15)
