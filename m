Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262954AbUE1MxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262954AbUE1MxK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 08:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbUE1MxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 08:53:10 -0400
Received: from smtp4.wanadoo.fr ([193.252.22.27]:13043 "EHLO
	mwinf0402.wanadoo.fr") by vger.kernel.org with ESMTP
	id S262873AbUE1Mw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 08:52:58 -0400
Message-ID: <40B7362B.8050905@reolight.net>
Date: Fri, 28 May 2004 14:52:59 +0200
From: Auzanneau Gregory <mls@reolight.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.6) Gecko/20040526 Debian/1.6-6
X-Accept-Language: fr, fr-fr, en, en-gb, en-us
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: idebus setup problem (2.6.7-rc1)
References: <Pine.LNX.4.44.0405281244220.22881-100000@mazda.sh.intel.com> <40B7022F.1020905@reolight.net> <200405281450.22879.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200405281450.22879.bzolnier@elka.pw.edu.pl>
X-Enigmail-Version: 0.83.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Bartlomiej Zolnierkiewicz a écrit :
> OK, now please explain why do you use 'idebus=66'. :-)

Because my SIS 5513 southbridge seems to run by default to 33Mhz.

-- 
Auzanneau Grégory
GPG 0x99137BEE
