Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422739AbWG2Kbe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422739AbWG2Kbe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 06:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422742AbWG2Kbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 06:31:34 -0400
Received: from abfc190.neoplus.adsl.tpnet.pl ([83.7.40.190]:57543 "EHLO
	pcserwis") by vger.kernel.org with ESMTP id S1422741AbWG2Kbd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 06:31:33 -0400
Date: Sat, 29 Jul 2006 12:30:44 +0200
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: metadata plugins (was Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion)
From: =?iso-8859-2?B?o3VrYXN6IE1pZXJ6d2E=?= <prymitive@pcserwis.hopto.org>
Organization: PC Serwis
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-2
MIME-Version: 1.0
In-Reply-To: <44CA126C.7050403@namesys.com>
References: <200607281402.k6SE245v004715@laptop13.inf.utfsm.cl> <44CA31D2.70203@slaphack.com> <Pine.LNX.4.64.0607280859380.4168@g5.osdl.org> <44C9FB93.9040201@namesys.com> <44CA6905.4050002@slaphack.com> <44CA126C.7050403@namesys.com>
Content-Transfer-Encoding: 8bit
Message-ID: <op.tdf4tigjd4os1z@localhost>
User-Agent: Opera Mail/9.00 (Linux)
X-PCSerwis-MailScanner-Information: Please contact the ISP for more information
X-PCSerwis-MailScanner: Found to be clean
X-PCSerwis-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-14.843, required 6, autolearn=not spam, ALL_TRUSTED -1.80,
	AWL 1.96, BAYES_00 -15.00)
X-MailScanner-From: prymitive@pcserwis.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia Fri, 28 Jul 2006 15:34:36 +0200, Hans Reiser <reiser@namesys.com>
napisa³:

> Let me put it from my perspective and stop pretending to be unbiased, so
> others can see where I am coming from.  No one was interested in our
> plugins.  We put the design on a website, spoke at conferences, no one
> but users were interested.  No one would have conceived of having
> plugins if not for us.  Our plugins affect no one else.  Our
> self-contained code should not be delayed because other people delayed
> getting interested in our ideas and now they don't want us to have an
> advantage from leading.  If they want to some distant day implement
> generic plugins, for which they have written not one line of code to
> date, fine, we'll use it when it exists, but right now those who haven't
> coded should get out of the way of people with working code.  It is not
> fair or just to do otherwise.  It also prevents users from getting
> advances they could be getting today, for no reason.  Our code will not
> be harder to change once it is in the kernel, it will be easier, because
> there will be more staff funded to work on it.
>
> As for this "we are all too grand to be bothered with money to feed our
> families" business, building a system in which those who contribute can
> find a way to be rewarded is what managers do.   Free software
> programmers may be willing to live on less than others, but they cannot
> live on nothing, and code that does not ever ship means living on  
> nothing.
>
> If reiser4 is delayed enough, for reasons that have nothing to do with
> its needs, and without it having encumbered anyone else, it won't be
> ahead of the other filesystems when it ships.
>

It just hited me that 90% of mails (those I've read and remember) in which
You guys are talking why r4 should or should not be merged did not contain
a patch or not even a line of code as a reference, most of complains feels
so abstract and ahead of time, there is nothing wrong with planing ahead
but does it still makes sense when nobody else actually said that he would
want to use it in future? Can't it be pusshed up to vfs later if it proves
itself and there is demand for it?
My question is what does it break now? It's been in mm for some time now,
what troubles does it couse? Did anyone complained that it breaks mm and
should be dropped?
I'm just a end user and have no idea of linux internals, but all the fuzz
about r4 seems so political and it's not just me who things so.
