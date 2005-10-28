Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751701AbVJ1Uxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbVJ1Uxq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 16:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751702AbVJ1Uxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 16:53:45 -0400
Received: from mail.dvmed.net ([216.237.124.58]:15086 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751700AbVJ1Uxo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 16:53:44 -0400
Message-ID: <43628FCB.9060202@pobox.com>
Date: Fri, 28 Oct 2005 16:53:31 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@davemloft.net>,
       Jes Sorensen <jes@trained-monkey.org>,
       Matt Porter <mporter@kernel.crashing.org>,
       Michael Chan <mchan@broadcom.com>, linux.nics@intel.com,
       hans@esrac.ele.tue.nl, Santiago Leon <santil@us.ibm.com>,
       Jean Tourrilhes <jt@hpl.hp.com>, Paul Mackerras <paulus@samba.org>,
       Michael Hipp <hippm@informatik.uni-tuebingen.de>,
       Jes Sorensen <jes@wildopensource.com>,
       Carsten Langgaard <carstenl@mips.com>,
       Benjamin Reed <breed@users.sourceforge.net>,
       Jouni Malinen <jkmaline@cc.hut.fi>, prism54-private@prism54.org,
       netdev@vger.kernel.org, Stuart Cheshire <cheshire@cs.stanford.edu>,
       g4klx@g4klx.demon.co.uk, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 02/14] Big kfree NULL check cleanup - drivers/net
References: <200510132122.48035.jesper.juhl@gmail.com>
In-Reply-To: <200510132122.48035.jesper.juhl@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> This is the drivers/net/ part of the big kfree cleanup patch.
> 
> Remove pointless checks for NULL prior to calling kfree() in drivers/net/.
> 
> 
> Sorry about the long Cc: list, but I wanted to make sure I included everyone
> who's code I've changed with this patch.
> 
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>

applied 98% of this


