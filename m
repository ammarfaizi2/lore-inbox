Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266324AbUITMCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266324AbUITMCk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 08:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266333AbUITMCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 08:02:40 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:14030 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S266324AbUITMCh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 08:02:37 -0400
Date: Mon, 20 Sep 2004 13:59:42 +0200
From: DervishD <lkml@dervishd.net>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: DervishD <lkml@dervishd.net>, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org
Subject: Re: OOM & [OT] util-linux-2.12e
Message-ID: <20040920115942.GG5684@DervishD>
Mail-Followup-To: Xavier Bestel <xavier.bestel@free.fr>,
	DervishD <lkml@dervishd.net>, Andries.Brouwer@cwi.nl,
	linux-kernel@vger.kernel.org
References: <UTC200409192205.i8JM52C25370.aeb@smtp.cwi.nl> <20040920110631.GJ5482@DervishD> <1095680326.27965.238.camel@gonzales>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1095680326.27965.238.camel@gonzales>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-PopBeforeSMTPSenders: raul@dervishd.net
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Xavier :)

 * Xavier Bestel <xavier.bestel@free.fr> dixit:
> > does the kernel *read* /proc/mounts contents?
> /proc/mounts is kernel-generated on the fly (it's alive only during the
> read() call).

    Then you can cripple it with any extra contents you want, am I
wrong? The kernel won't mind...

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
