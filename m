Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263311AbTDZKRR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 06:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263384AbTDZKRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 06:17:17 -0400
Received: from portraits.wsisiz.edu.pl ([213.135.44.34]:51577 "EHLO
	portraits.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id S263311AbTDZKRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 06:17:16 -0400
Date: Sat, 26 Apr 2003 12:28:29 +0200
Message-Id: <200304261028.h3QASTjv001439@lt.wsisiz.edu.pl>
From: Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-rc1 freezes
In-Reply-To: <3EA8D45A.3070205@web.de>
X-Newsgroups: wsisiz.linux-kernel
X-PGP-Key-Fingerprint: 87 9F 39 9C F9 EE EA 7F  8F C9 58 6A D4 54 0E B9
X-Key-ID: 6DB9C699
User-Agent: tin/1.5.17-20030407 ("Peephole") (UNIX) (Linux/2.4.21-pre6 (i686))
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3EA8D45A.3070205@web.de> you wrote:
> after some time rc1 always freezes on my system.
> I tried it three times:
> 
> 1. I was running lopster under X. When I came home from work
> my screen told me "no input signal".
> 
> 2. I ripped a cd using cdparanoia and oggenc under X.
> After some time (1/2 hour maybe) the system freezed.
> 
> 3. Same disc on a tty -> The next morning I had a black screen.
> (this time with apm and acpi disabled).

I can to confirm this bug, I have the identical effects.
 
> BTW: I could find nothing interesting in /var/log/messages and
> /var/log/warn

Me too. :(

-- 
*[ £ukasz Tr±biñski ]*
