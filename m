Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263328AbTETA3t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 20:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263333AbTETA3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 20:29:49 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:21669 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP id S263328AbTETA3s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 20:29:48 -0400
Message-ID: <3EC9807D.3080804@kegel.com>
Date: Mon, 19 May 2003 18:10:21 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: John Myers <jgmyers@netscape.com>, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: Comparing the aio and epoll event frameworks.
References: <200305192333.QAA12018@pagarcia.nscp.aoltw.net> <Pine.LNX.4.55.0305191657540.6565@bigblue.dev.mcafeelabs.com>
In-Reply-To: <Pine.LNX.4.55.0305191657540.6565@bigblue.dev.mcafeelabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> Adding a single shot feature to epoll takes about 5 lines of code,
> comments included :) You know how many reuqests I had ? Zero, nada.

I thought edge triggered epoll *was* single-shot.
- Dan

-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045

