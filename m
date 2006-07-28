Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161287AbWG1UfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161287AbWG1UfB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 16:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161290AbWG1UfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 16:35:01 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:12417 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S1161287AbWG1UfA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 16:35:00 -0400
Message-ID: <44CA126C.7050403@namesys.com>
Date: Fri, 28 Jul 2006 07:34:36 -0600
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Masover <ninja@slaphack.com>
CC: Linus Torvalds <torvalds@osdl.org>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       Theodore Tso <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: metadata plugins (was Re: the " 'official' point of view" expressed
 by kernelnewbies.org regarding reiser4 inclusion)
References: <200607281402.k6SE245v004715@laptop13.inf.utfsm.cl> <44CA31D2.70203@slaphack.com> <Pine.LNX.4.64.0607280859380.4168@g5.osdl.org> <44C9FB93.9040201@namesys.com> <44CA6905.4050002@slaphack.com>
In-Reply-To: <44CA6905.4050002@slaphack.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Let me put it from my perspective and stop pretending to be unbiased, so
others can see where I am coming from.  No one was interested in our
plugins.  We put the design on a website, spoke at conferences, no one
but users were interested.  No one would have conceived of having
plugins if not for us.  Our plugins affect no one else.  Our
self-contained code should not be delayed because other people delayed
getting interested in our ideas and now they don't want us to have an
advantage from leading.  If they want to some distant day implement
generic plugins, for which they have written not one line of code to
date, fine, we'll use it when it exists, but right now those who haven't
coded should get out of the way of people with working code.  It is not
fair or just to do otherwise.  It also prevents users from getting
advances they could be getting today, for no reason.  Our code will not
be harder to change once it is in the kernel, it will be easier, because
there will be more staff funded to work on it.

As for this "we are all too grand to be bothered with money to feed our
families" business, building a system in which those who contribute can
find a way to be rewarded is what managers do.   Free software
programmers may be willing to live on less than others, but they cannot
live on nothing, and code that does not ever ship means living on nothing.

If reiser4 is delayed enough, for reasons that have nothing to do with
its needs, and without it having encumbered anyone else, it won't be
ahead of the other filesystems when it ships.

