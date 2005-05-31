Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbVEaUKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbVEaUKr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 16:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbVEaUKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 16:10:47 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:39335 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261424AbVEaUKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 16:10:10 -0400
Subject: Re: RT patch acceptance
From: Lee Revell <rlrevell@joe-job.com>
To: Andi Kleen <ak@muc.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, karim@opersys.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org, hch@infradead.org,
       dwalker@mvista.com, Ingo Molnar <mingo@elte.hu>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       James Bruce <bruce@andrew.cmu.edu>, kus Kusche Klaus <kus@keba.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Esben Nielsen <simlo@phys.au.dk>,
       "Bill Huey (hui)" <bhuey@lnxw.com>
In-Reply-To: <20050531200114.GD9372@muc.de>
References: <Pine.OSF.4.05.10505301934001.31148-100000@da410.phys.au.dk>
	 <429B61F7.70608@opersys.com> <20050530223434.GC9972@nietzsche.lynx.com>
	 <429B9880.1070604@opersys.com> <20050530224949.GE9972@nietzsche.lynx.com>
	 <429B9E85.2000709@opersys.com>
	 <1117556975.2569.37.camel@localhost.localdomain>
	 <20050531200114.GD9372@muc.de>
Content-Type: text/plain
Date: Tue, 31 May 2005 16:10:05 -0400
Message-Id: <1117570206.23283.28.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-31 at 22:01 +0200, Andi Kleen wrote:
> On Tue, May 31, 2005 at 12:29:35PM -0400, Steven Rostedt wrote:
> > I would assume that the distros would ship without PREEMPT enabled
> > because it was (and probably still is) considered unstable. 
> 
> In addition to that it is slow too due to much increased locking
> overhead.

Doesn't this imply that distros will need to ship different kernels for
their desktop and server oriented products anyway?

Lee

