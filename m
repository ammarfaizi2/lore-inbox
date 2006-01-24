Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030198AbWAXOWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030198AbWAXOWO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 09:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbWAXOWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 09:22:14 -0500
Received: from lila.akte.de ([213.239.211.75]:60879 "EHLO lila.akte.de")
	by vger.kernel.org with ESMTP id S932318AbWAXOWN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 09:22:13 -0500
KRecCount: 1
KInfo: virscan ok
KInfo: !spam auth
Date: Tue, 24 Jan 2006 15:21:51 +0100
From: Andy Spiegl <kernelbug.Andy@spiegl.de>
To: John Stoffel <john@stoffel.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.15 crashes X Server after running OpenGL programs
Message-ID: <20060124142151.GA3538@spiegl.de>
Mail-Followup-To: Andy Spiegl <kernelbug.Andy@spiegl.de>,
	John Stoffel <john@stoffel.org>, linux-kernel@vger.kernel.org
References: <20060124121542.GB13646@spiegl.de> <17366.13811.386903.438419@smtp.charter.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17366.13811.386903.438419@smtp.charter.net>
X-PGP-GPG-Keys: mail -s "send pgp" auto@spiegl.de
X-Accepted-File-Formats: ASCII OpenOffice .rtf .pdf - *NO* Microsoft files please.
X-why-you-shouldnt-use-MS-LookOut: http://www.jensbenecke.de/l-oe-en.php
X-warum-man-MS-Outlook-vermeiden-sollte: http://www.jensbenecke.de/l-oe-de.php
X-Message-Flag: LookOut! You are using an insecure mail reader which can be used to spread viruses.
X-how-to-quote: http://learn.to/quote/
X-how-to-ask-questions: http://www.catb.org/~esr/faqs/smart-questions.html
X-stupid-disclaimers: http://goldmark.org/jeff/stupid-disclaimers/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Talk to ATI, it's their code doing something wrong.
Okay, knowing that for sure already helped me.

I thought that it's a bug in the kernel source because syslog says
"kernel BUG at mm/swap.c" and swap.c isn't part of fglrx.

Too bad there is no free OpenGL driver - I hate to use closed source stuff.

Thanks,
 Andy.

-- 
 Fotos: francisco.spiegl.de            o      _     _         _              
 Infos: peru.spiegl.de       __o      /\_   _ \\o  (_)\__/o  (_)         -o) 
 Andy, Heidi, Francisco    _`\<,_    _>(_) (_)/<_    \_| \   _|/' \/      /\\
 heidi.und.andy@spiegl.de (_)/ (_)  (_)        (_)   (_)    (_)'  _\o_   _\_v
 ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
 I stand by all the misstatements that I've made.  (Dan Quayle)
