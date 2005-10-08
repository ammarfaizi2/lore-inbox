Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750896AbVJHKTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbVJHKTl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 06:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbVJHKTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 06:19:41 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:26818 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750891AbVJHKTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 06:19:41 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <43479CF2.80408@s5r6.in-berlin.de>
Date: Sat, 08 Oct 2005 12:18:26 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, stable@kernel.org
CC: Chris Wright <chrisw@osdl.org>, Grant Coady <grant_lkml@dodo.com.au>,
       Greg KH <gregkh@suse.de>, torvalds@osdl.org,
       "Theodore Ts'o" <tytso@mit.edu>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Justin Forbes <jmforbes@linuxtx.org>,
       Randy Dunlap <rdunlap@xenotime.net>, bcollins@debian.org,
       Chuck Wolber <chuckw@quantumlinux.com>, alan@lxorguk.ukuu.org.uk
Subject: Re: [stable] Re: [patch 1/7] ieee1394/sbp2: fixes for hot-unplug
 and module unloading
References: <20051007234348.631583000@press.kroah.org> <20051007235353.GA23111@kroah.com> <20051007235422.GB23111@kroah.com> <004ek192bmh6t6ei08cpnusf8dmpi0dk6d@4ax.com> <20051008002109.GM5856@shell0.pdx.osdl.net>
In-Reply-To: <20051008002109.GM5856@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-1.479) AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> * Grant Coady (grant_lkml@dodo.com.au) wrote:
>>^^^^^ How did that 0x0c character sneak in there?
> 
> It's from the patched file (predating the patch, yes it should go, but
> that's another story).

Thanks. A code formatting cleanup is on my todo list.
-- 
Stefan Richter
-=====-=-=-= =-=- -=---
http://arcgraph.de/sr/
