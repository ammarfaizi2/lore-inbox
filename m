Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265223AbTLZTPQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 14:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265224AbTLZTPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 14:15:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:38069 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265223AbTLZTPO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 14:15:14 -0500
Date: Fri, 26 Dec 2003 11:15:09 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Matthias Urlichs <smurf@smurf.noris.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: SUCCESS Re: 2.6.0-test11-mm1
In-Reply-To: <pan.2003.12.26.18.22.17.611727@smurf.noris.de>
Message-ID: <Pine.LNX.4.58.0312261114040.14874@home.osdl.org>
References: <20031217014350.028460b2.akpm@osdl.org>
 <pan.2003.12.26.18.22.17.611727@smurf.noris.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 26 Dec 2003, Matthias Urlichs wrote:
> 
> If somebody _really_ needs to know, I can try to binary-search for the
> patch that's responsible, but it'd take a month to find out anything
> conclusive -- ten reboots, two days of stress testing each in order to
> eliminate false positives, and a few days of no-computer-please,
> I-need-a-holiday time. Thus, I'd rather not.

It would be good to even get a "good hint", even if it won't be 
conclusive. Even if it starts out as just a list of "this patch can't 
matter, because it's not active in my configuration", and perhaps then 
specified a bit better afterwards..

		Linus
