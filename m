Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265367AbSJXJsi>; Thu, 24 Oct 2002 05:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265368AbSJXJsi>; Thu, 24 Oct 2002 05:48:38 -0400
Received: from mail.hometree.net ([212.34.181.120]:5316 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S265367AbSJXJsi>; Thu, 24 Oct 2002 05:48:38 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: 2.5.44-[mm3, ac2] time to tar zxf kernel tarball compared forvarious
Date: Thu, 24 Oct 2002 09:54:49 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <ap8g19$8k4$1@forge.intermeta.de>
References: <1035402133.13140.251.camel@spc9.esa.lanl.gov> 	<3DB6FF24.9B50A7C0@digeo.com> <1035405140.13083.268.camel@spc9.esa.lanl.gov> <3DB764B0.3010204@namesys.com>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1035453289 15610 212.34.181.4 (24 Oct 2002 09:54:49 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Thu, 24 Oct 2002 09:54:49 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> writes:

>simple tests like this.  We recently ran into one with tar recognizing 
>that it was writing to /dev/null, and optimizing for it.

As stated in the info document. It is there for a reason (Amanda).

--- cut ---
   When the archive is being created to `/dev/null', GNU `tar' tries to
minimize input and output operations.  The Amanda backup system, when
used with GNU `tar', has an initial sizing pass which uses this feature.
--- cut ---

	Regards
		Henning


>Hans

>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
