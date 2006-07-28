Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbWG1Cqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWG1Cqo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 22:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbWG1Cqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 22:46:43 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:48068 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1750764AbWG1Cqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 22:46:43 -0400
From: Grant Coady <gcoady.lk@gmail.com>
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-kernel@vger.kernel.org, mtosatti@redhat.com, willy@w.ods.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: Linux v2.4.33-rc3 (and a new v2.4 maintainer)
Date: Fri, 28 Jul 2006 12:46:31 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <nbuic2ljd8n5g43k74tussq2hm5nvrn04e@4ax.com>
References: <200607280216.k6S2GgiJ009955@harpo.it.uu.se>
In-Reply-To: <200607280216.k6S2GgiJ009955@harpo.it.uu.se>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2006 04:16:42 +0200 (MEST), Mikael Pettersson <mikpe@it.uu.se> wrote:

>On Thu, 27 Jul 2006 18:30:19 -0300, Marcelo Tosatti wrote:
>>Here goes the third (and hopefully last) release candidate of v2.4.33.
>
>http://www.kernel.org/pub/linux/kernel/v2.4/testing/patch-2.4.33-rc3.bz2
>is only 854 bytes long, and once bunzip2:ed it looks like it's the
>incremental diff between rc2 and rc3. Usually the full pre/rc patches
>go in testing/ with the incrementals going into testing/incr/.
>
>No big deal, but it would feel better with a proper -rc3 patch there.
>

Yeah, stuff happens ;)  

At the moment one needs 2.4.32 plus patches -rc2 and -rc3, like you 
say, very obvious from patch file sizes ;)

At least -rc3 goes okay on 7 of 7 test boxen here: 
  <http://bugsplatter.mine.nu/test/linux-2.4/>

Cheers,
Grant.
