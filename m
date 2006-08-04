Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161061AbWHDJMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161061AbWHDJMY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 05:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161119AbWHDJMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 05:12:24 -0400
Received: from stinky.trash.net ([213.144.137.162]:38603 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1161061AbWHDJMX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 05:12:23 -0400
Message-ID: <44D30F04.9060300@trash.net>
Date: Fri, 04 Aug 2006 11:10:28 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [patch 00/23] -stable review
References: <20060804053807.GA769@kroah.com> <9a8748490608040204o58f7f594qe8c3316fcdf00ea4@mail.gmail.com>
In-Reply-To: <9a8748490608040204o58f7f594qe8c3316fcdf00ea4@mail.gmail.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> Any chance that the fixes in the (latest) e1000 driver version
> 7.1.9-k4 will get backported?
> 
> I get messages along the lines of "kernel: Virtual device XXX asks to
> queue packet!" and the device then refuses to work.
> The last kernel where I know for a fact that it worked OK is 2.6.11,
> so that's what the server is currently running.

That message should never be seen on a device with a queue. What device
exactly is "XXX"?

