Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135500AbRAGBV1>; Sat, 6 Jan 2001 20:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135503AbRAGBVR>; Sat, 6 Jan 2001 20:21:17 -0500
Received: from mail0.netcom.net.uk ([194.42.236.2]:63986 "EHLO
	mail0.netcom.net.uk") by vger.kernel.org with ESMTP
	id <S135500AbRAGBVM>; Sat, 6 Jan 2001 20:21:12 -0500
Message-ID: <3A57C515.A7B9FE@netcomuk.co.uk>
Date: Sun, 07 Jan 2001 01:23:33 +0000
From: Bill Crawford <billc@netcomuk.co.uk>
Organization: Netcom Internet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-prerelease i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.0-ac2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Many thanks, but I just cleaned it up ... the real credit belongs to
Ian Hastie <ianh@iahastie.clara.net>.

 o Fix mac address setting in 8139too (Ben Greear)
-o AGP oops fix/ALi cleanup (Bill Crawford)
+o AGP oops fix/ALi cleanup (Ian Hastie)
 o Further DECnet cleanups (Hans Grobler)

-- 
/* Bill Crawford, Unix Systems Developer, ebOne, formerly GTS Netcom */
#include "stddiscl.h"
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
