Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265093AbTF3Puw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 11:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265128AbTF3Puv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 11:50:51 -0400
Received: from mail.hometree.net ([212.34.181.120]:18819 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP id S265093AbTF3Pul
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 11:50:41 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: File System conversion -- ideas
Date: Mon, 30 Jun 2003 16:05:00 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <bdpn3c$te5$1@tangens.hometree.net>
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk> <20030629132807.GA25170@mail.jlokier.co.uk> <3EFEEEC3.30505@sktc.net>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1056989100 30149 212.34.181.4 (30 Jun 2003 16:05:00 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Mon, 30 Jun 2003 16:05:00 +0000 (UTC)
X-Copyright: (C) 1996-2003 Henning Schmiedehausen
X-No-Archive: yes
User-Agent: nn/6.6.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David D. Hagood" <wowbagger@sktc.net> writes:

>For example, suppose you have a 60G disk, 55G of data, in ext2, and you 
>wish to convert to ReiserFS.

>Step 1: Shrink the volume to 55G. This requires a "shrink disk" utility 
>for the source file system (which exists for the major file systems in 
>use today).

You have a 6 GB file. You lose. :-)

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen          INTERMETA GmbH
hps@intermeta.de        +49 9131 50 654 0   http://www.intermeta.de/

Java, perl, Solaris, Linux, xSP Consulting, Web Services 
freelance consultant -- Jakarta Turbine Development  -- hero for hire

--- Quote of the week: "It is pointless to tell people anything when
you know that they won't process the message." --- Jonathan Revusky
