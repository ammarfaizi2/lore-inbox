Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbTFTN73 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 09:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbTFTN73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 09:59:29 -0400
Received: from mail.hometree.net ([212.34.181.120]:34186 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP id S262283AbTFTN7V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 09:59:21 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: Problems with IDE on GA-7VAXP motherboard
Date: Fri, 20 Jun 2003 14:13:21 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <bcv4q1$sgv$2@tangens.hometree.net>
References: <200306191429.40523.bernd-schubert@web.de> <20030619193118.GA32406@charter.net> <20030620075249.GA7833@charter.net>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1056118401 29215 212.34.181.4 (20 Jun 2003 14:13:21 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Fri, 20 Jun 2003 14:13:21 +0000 (UTC)
X-Copyright: (C) 1996-2003 Henning Schmiedehausen
X-No-Archive: yes
User-Agent: nn/6.6.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

misty-@charter.net writes:

>I believe I have nailed the problem to the wall. Your talk about the
>bios misdetecting the cable got me to thinking - I hadn't actually been
>able to see what the bios said it was configuring the disks attached to
>since lilo's menu came up microseconds later.

Put your Boot Sequence on "Floppy --> Anything else" and format a floppy
with just plain DOS. :-)

Works for me every time. 

	Regards
		Henning


-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen          INTERMETA GmbH
hps@intermeta.de        +49 9131 50 654 0   http://www.intermeta.de/

Java, perl, Solaris, Linux, xSP Consulting, Web Services 
freelance consultant -- Jakarta Turbine Development  -- hero for hire
