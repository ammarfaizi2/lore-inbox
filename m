Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964886AbWEJKRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbWEJKRp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 06:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbWEJKRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 06:17:44 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:33927 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964886AbWEJKRo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 06:17:44 -0400
Date: Wed, 10 May 2006 12:17:29 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: akpm@osdl.org, Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Document futex PI design
Message-ID: <20060510101729.GB31504@elte.hu>
References: <Pine.LNX.4.58.0605090954150.7007@gandalf.stny.rr.com> <Pine.LNX.4.58.0605100331290.31598@gandalf.stny.rr.com> <Pine.LNX.4.58.0605100429220.436@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0605100429220.436@gandalf.stny.rr.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> +# This document is copyright 2006 by Steven Rostedt
> +# It is licensed under the GFDL version 1.2 which can be
> +# downloaded at http://www.kihontech.com/license/fdl.txt

s/at/from

in fact i'd suggest this:

> +# Copyright (c) 2006 Steven Rostedt
> +# Licensed under the GNU Free Documentation License, Version 1.2

and without the URL. (you really dont want to make a license partly 
depend on an URL and thus making it potentially ambigious. Saying GFDL 
1.2 is specific enough.)

	Ingo
