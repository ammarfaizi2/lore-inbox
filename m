Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269236AbUIHXrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269236AbUIHXrG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 19:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269221AbUIHXrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 19:47:05 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:18833 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269250AbUIHXom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 19:44:42 -0400
Subject: Re: NETWORK broken at least for 2.6.8.1 and 2.6.9-rc1
From: Lee Revell <rlrevell@joe-job.com>
To: Paulo da Silva <psdasilva@esoterica.pt>
Cc: "David S. Miller" <davem@davemloft.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <413F9304.8090704@esoterica.pt>
References: <413E4A7D.8010401@esoterica.pt>
	 <20040907170935.7c6ac4ac.davem@davemloft.net>
	 <413F9304.8090704@esoterica.pt>
Content-Type: text/plain
Message-Id: <1094687085.1362.249.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 08 Sep 2004 19:44:46 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-08 at 19:17, Paulo da Silva wrote:
> David S. Miller wrote:
> 
> >See:
> >
> >http://lwn.net/Articles/92727/
> >  
> >
>  From the 2 "solutions" presented there, echoeing 0 to the
> proc works. The line to be inserted into /etc/sysctl.conf
> does not seem to work!
> 

You would have to run sysctl -p to activate the new entry.  Better to
save yourself some trouble and fix the router.

Lee

