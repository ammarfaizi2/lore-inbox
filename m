Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261515AbREQTYV>; Thu, 17 May 2001 15:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261517AbREQTYL>; Thu, 17 May 2001 15:24:11 -0400
Received: from ns.muni.cz ([147.251.4.33]:32724 "EHLO aragorn.ics.muni.cz")
	by vger.kernel.org with ESMTP id <S261518AbREQTX5>;
	Thu, 17 May 2001 15:23:57 -0400
Newsgroups: cz.muni.redir.linux-kernel
Path: news
From: Zdenek Kabelac <kabi@i.am>
Subject: hang with 2.4.5-pre3
Message-ID: <3B042555.A071AA5B@i.am>
Date: Thu, 17 May 2001 19:24:05 GMT
X-Nntp-Posting-Host: dual.fi.muni.cz
Content-Transfer-Encoding: 7bit
X-Accept-Language: cs, en
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre1-RTL3.0 i686)
Organization: unknown
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Just pointing out that my system has locked hard in XWindows system.
Sorry no-oops as linux so far is unable to switch to VGA mode in this
case
and show me this log.

I'd not seen any oops with 2.4.5-pre1 during the whole usage of this
kernel
on my SMP box BP6.

-pre3 has locked after 5 hours - and I've been working with this machine
only for the last hour.

I could only describe situation: - starting multithread application
which has been loading data across nfs.

Thats all I can say ... switching back to -pre1
(BTW Core is still no being generated for threaded apps in -pre3 -
please fix)

bye

kabi

