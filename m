Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263408AbTIBBol (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 21:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263411AbTIBBol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 21:44:41 -0400
Received: from smtp14.eresmas.com ([62.81.235.114]:65507 "EHLO
	smtp14.eresmas.com") by vger.kernel.org with ESMTP id S263408AbTIBBok
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 21:44:40 -0400
Message-ID: <3F53F5BC.1030404@wanadoo.es>
Date: Tue, 02 Sep 2003 03:43:24 +0200
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.22pre7aa1: unresolved in sk98lin
References: <3F53EC5F.5090005@wanadoo.es> <20030902010903.GA1599@dualathlon.random>
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

> On Tue, Sep 02, 2003 at 03:03:27AM +0200, Xose Vazquez Perez wrote:

>>2.4.23-prex driver is very old(v6.02 Dec-2002)
>>patch-2.4.22-ac1 has more recent version but latest are at SK web site:
>>http://www.syskonnect.com/syskonnect/support/driver/htm/sk98lin.htm
> 
> 
> applied, thanks.
> 
> Andrea

be careful, SK has made a stupid patch for net/configure.in.
And it has several NICs selections but the driver is same for all of them.

-- 
Que trabajen los romanos, que tienen el pecho de lata.

