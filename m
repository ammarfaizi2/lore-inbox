Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290292AbSAPAP5>; Tue, 15 Jan 2002 19:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290298AbSAPAPr>; Tue, 15 Jan 2002 19:15:47 -0500
Received: from tangens.hometree.net ([212.34.181.34]:32190 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S290292AbSAPAPk>; Tue, 15 Jan 2002 19:15:40 -0500
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: CML2-2.1.3 is available
Date: Wed, 16 Jan 2002 00:15:39 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <a22gnb$c2s$1@forge.intermeta.de>
In-Reply-To: <20020115145324.A5772@thyrsus.com> <Pine.LNX.4.33.0201151514090.5892-100000@xanadu.home> <20020115151804.A6308@thyrsus.com>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1011140139 29678 212.34.181.4 (16 Jan 2002 00:15:39 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Wed, 16 Jan 2002 00:15:39 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" <esr@thyrsus.com> writes:

>Rob Landley pointed out correctly that the vitality flag was not
>actually solving this problem, and it was an ugly wart on the
>language.  Instead, there's a symbol property "BOOTABLE" in the new
>rulebase that is attached to IDE and SCSI hardware symbols that are
>controllers for what could be boot devices.

Wasn't this SunOS (Larry?):  "Can't boot a typewriter."

Actually, some can. Or maybe their current incarnation, the serial port.

Will you make every thinkable device "BOOTABLE"? USB?

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
