Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261951AbTCYLY3>; Tue, 25 Mar 2003 06:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261994AbTCYLY3>; Tue, 25 Mar 2003 06:24:29 -0500
Received: from mail.hometree.net ([212.34.181.120]:40620 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S261951AbTCYLY2>; Tue, 25 Mar 2003 06:24:28 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: Ptrace hole / Linux 2.2.25
Date: Tue, 25 Mar 2003 11:35:37 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <b5peu9$rfu$1@tangens.hometree.net>
References: <20030323193457.GA14750@atrey.karlin.mff.cuni.cz> <200303231938.h2NJcAq14927@devserv.devel.redhat.com> <20030323194423.GC14750@atrey.karlin.mff.cuni.cz> <1048448838.1486.12.camel@phantasy.awol.org> <20030323195606.GA15904@atrey.karlin.mff.cuni.cz> <1048450211.1486.19.camel@phantasy.awol.org> <402760000.1048451441@[10.10.2.4]>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1048592137 28158 212.34.181.4 (25 Mar 2003 11:35:37 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Tue, 25 Mar 2003 11:35:37 +0000 (UTC)
X-Copyright: (C) 1996-2003 Henning Schmiedehausen
X-No-Archive: yes
User-Agent: nn/6.6.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> writes:

>The distros inherently have a conflict of interest getting changes merged
>back into mainline ... it's time consuming to do, it provides them no real
>benefit (they have to maintain their huge trees anyway), and it actively
>damages the "value add" they provide.

Well, I hope that the fragmentation of Unix in the 80'ies with the
resulting rise of an unified OS to be marked leader ("DOS", then
"Windows") should've learned that lesson with the vendors.

Linux ATM is heading exactly in the same direction as Unix went when
Sun/HP/IBM/DEC decided not to keep an unified Unix base. It isn't
heading that fast, mainly because the vendors must keep open source
trees and they work from a central baseline ("Linus kernels") but we
already have various distributions which sell "Linux" with a hugely
different kernel. Think e.g.  VM or devfs. Or supported file systems.

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen          INTERMETA GmbH
hps@intermeta.de        +49 9131 50 654 0   http://www.intermeta.de/

Java, perl, Solaris, Linux, xSP Consulting, Web Services 
freelance consultant -- Jakarta Turbine Development  -- hero for hire
