Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbTIIGlT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 02:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbTIIGlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 02:41:19 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:17553
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S262078AbTIIGlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 02:41:17 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms
Date: Tue, 9 Sep 2003 16:49:00 +1000
User-Agent: KMail/1.5.3
Cc: Andrew Morton <akpm@osdl.org>, Steven Pratt <slpratt@austin.ibm.com>,
       linux-kernel@vger.kernel.org
References: <3F5D023A.5090405@austin.ibm.com> <200309091231.48709.kernel@kolivas.org> <3F5D53B9.8050004@cyberone.com.au>
In-Reply-To: <3F5D53B9.8050004@cyberone.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309091649.00086.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Sep 2003 14:14, Nick Piggin wrote:
> Hi Con,
> Any chance you could give this
> http://www.kerneltrap.org/~npiggin/v14/sched-rollup-nopolicy-v14.gz
> a try? It should apply against test5.

Tested. This patch causes a drop in volano throughput of around 8% also like 
the other patches. I guess this patch must be good too :P

Con

