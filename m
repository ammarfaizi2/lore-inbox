Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265000AbTFCNFS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 09:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264995AbTFCNFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 09:05:18 -0400
Received: from mail.hometree.net ([212.34.181.120]:63669 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP id S265000AbTFCNFQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 09:05:16 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: Question about style when converting from K&R to ANSI C.
Date: Tue, 3 Jun 2003 13:18:43 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <bbi77j$mb3$1@tangens.hometree.net>
References: <1054446976.19557.23.camel@spc> <20030601132626.GA3012@work.bitmover.com> <1054519757.161606@palladium.transmeta.com> <20030603123256.GG1253@admingilde.org> <20030603124501.GB13838@suse.de>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1054646323 22883 212.34.181.4 (3 Jun 2003 13:18:43 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Tue, 3 Jun 2003 13:18:43 +0000 (UTC)
X-Copyright: (C) 1996-2003 Henning Schmiedehausen
X-No-Archive: yes
User-Agent: nn/6.6.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@codemonkey.org.uk> writes:

>On Tue, Jun 03, 2003 at 02:32:56PM +0200, Martin Waitz wrote:

> > well, but it is nice to be able to grep for the declaration of a
> > function like
> > 
> > 	grep "^where_is_it" *.c
> > 
> > without showing all the uses of that function.

>What's wrong with ctags for this?

<sarcasm>
Bah, all this newfangled crap like ctags. We've used grep for 30 years
and there is no reason to change this now. 
</sarcasm>

Dave, the arguments some people bring to simply cling to their
formatting reminds me of the arguments that the church had in the 14th
century to still prove that the sun revolves around the earth. Simply
ignore them. I'm grateful that there are programming environments
beyond vi. [1] :-)

	Regards
		Henning

[1] emacs 

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen          INTERMETA GmbH
hps@intermeta.de        +49 9131 50 654 0   http://www.intermeta.de/

Java, perl, Solaris, Linux, xSP Consulting, Web Services 
freelance consultant -- Jakarta Turbine Development  -- hero for hire
