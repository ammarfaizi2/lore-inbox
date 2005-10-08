Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161041AbVJHBtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161041AbVJHBtS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 21:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932614AbVJHBtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 21:49:18 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:17341 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S932108AbVJHBtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 21:49:17 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: sasa.ostrouska@volja.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops in 2.6.14-rc3
Date: Sat, 08 Oct 2005 11:48:44 +1000
Organization: http://bugsplatter.mine.nu/
Message-ID: <a49ek19jmmihflqguh7s2df2bvc6896f3n@4ax.com>
References: <1128731551.8004.2.camel@rc-vaio.rcdiostrouska.com>
In-Reply-To: <1128731551.8004.2.camel@rc-vaio.rcdiostrouska.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 08 Oct 2005 02:32:31 +0200, Sasa Ostrouska <sasa.ostrouska@volja.net> wrote:

>Hi ppl, 
>
>	After some playing with my new slackware 10.2 and 
>kernel 2.6.14-rc3 I noted this oops when shutting down the machine.
>Can somebody tell me why ?
>
>Oct  8 02:20:33 rc-vaio kernel: Unable to handle kernel paging request
>at virtual address f8c19706

What does 'grep swap /var/log/dmesg' have to say about it?

Grant.
