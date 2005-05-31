Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbVEaUBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbVEaUBl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 16:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbVEaUBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 16:01:40 -0400
Received: from colin.muc.de ([193.149.48.1]:263 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261381AbVEaUBU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 16:01:20 -0400
Date: 31 May 2005 22:01:14 +0200
Date: Tue, 31 May 2005 22:01:14 +0200
From: Andi Kleen <ak@muc.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: karim@opersys.com, linux-kernel@vger.kernel.org, akpm@osdl.org,
       hch@infradead.org, dwalker@mvista.com, Ingo Molnar <mingo@elte.hu>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       James Bruce <bruce@andrew.cmu.edu>, kus Kusche Klaus <kus@keba.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Esben Nielsen <simlo@phys.au.dk>,
       "Bill Huey \(hui\)" <bhuey@lnxw.com>
Subject: Re: RT patch acceptance
Message-ID: <20050531200114.GD9372@muc.de>
References: <Pine.OSF.4.05.10505301934001.31148-100000@da410.phys.au.dk> <429B61F7.70608@opersys.com> <20050530223434.GC9972@nietzsche.lynx.com> <429B9880.1070604@opersys.com> <20050530224949.GE9972@nietzsche.lynx.com> <429B9E85.2000709@opersys.com> <1117556975.2569.37.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117556975.2569.37.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2005 at 12:29:35PM -0400, Steven Rostedt wrote:
> I would assume that the distros would ship without PREEMPT enabled
> because it was (and probably still is) considered unstable. 

In addition to that it is slow too due to much increased locking
overhead.

-Andi
