Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261384AbSIWU6i>; Mon, 23 Sep 2002 16:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261387AbSIWU6i>; Mon, 23 Sep 2002 16:58:38 -0400
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:46720 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S261384AbSIWU6h>; Mon, 23 Sep 2002 16:58:37 -0400
Date: Mon, 23 Sep 2002 14:03:46 -0700
To: Peter Waechtler <pwaechtler@mac.com>
Cc: linux-kernel@vger.kernel.org, ingo Molnar <mingo@redhat.com>,
       "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Message-ID: <20020923210346.GA2075@gnuppy.monkey.org>
References: <E2E1F730-CE5C-11D6-8873-00039387C942@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E2E1F730-CE5C-11D6-8873-00039387C942@mac.com>
User-Agent: Mutt/1.4i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 22, 2002 at 08:55:39PM +0200, Peter Waechtler wrote:
> AIX and Irix deploy M:N - I guess for a good reason: it's more
> flexible and combine both approaches with easy runtime tuning if
> the app happens to run on SMP (the uncommon case).

Also, for process scoped scheduling in a way so that system wide threads
don't have an impact on a process slice. Folks have piped up about that
being important.

bill

