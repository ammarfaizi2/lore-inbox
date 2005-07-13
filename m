Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262968AbVGMQBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262968AbVGMQBp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 12:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262963AbVGMQBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 12:01:45 -0400
Received: from opersys.com ([64.40.108.71]:58383 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262684AbVGMQBE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 12:01:04 -0400
Message-ID: <42D53956.5020506@opersys.com>
Date: Wed, 13 Jul 2005 11:55:02 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: =?UTF-8?B?VG9tYXN6IEvFgm9jemtv?= <kloczek@rudy.mif.pg.gda.pl>
CC: Vara Prasad <prasadav@us.ibm.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org
Subject: Re: Merging relayfs?
References: <17107.6290.734560.231978@tut.ibm.com> <Pine.BSO.4.62.0507121544450.6919@rudy.mif.pg.gda.pl> <17107.57046.817407.562018@tut.ibm.com> <Pine.BSO.4.62.0507121731290.6919@rudy.mif.pg.gda.pl> <17107.61271.924455.965538@tut.ibm.com> <Pine.BSO.4.62.0507121840260.6919@rudy.mif.pg.gda.pl> <42D498AF.5070401@us.ibm.com> <Pine.BSO.4.62.0507131440480.6919@rudy.mif.pg.gda.pl>
In-Reply-To: <Pine.BSO.4.62.0507131440480.6919@rudy.mif.pg.gda.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Tomasz Kłoczko wrote:
> *NOT using realyfs* if it is not neccessary for possibly big amout 
> of feactures future KProbes IMO in this case is *fundamental*.
> 
> To time where this base not requiring relayfs feactures will not be
> integrated in kernel code better IMO will be stop merging relayfs.

This part of the thread is really veering off-topic. This counters thing is
your own personal crusade and has nothing to do with the fundamental need
for a generic buffering mechanism such as relayfs.

I would suggest you start a separate thread to discuss the implementation of
a generic counters mechanism, if that's indeed what you're interested in.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
