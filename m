Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965151AbWADABn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965151AbWADABn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 19:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965150AbWADABm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 19:01:42 -0500
Received: from mail.gmx.de ([213.165.64.21]:46016 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965146AbWADABl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 19:01:41 -0500
X-Authenticated: #4399952
Date: Wed, 4 Jan 2006 01:01:38 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rt1
Message-ID: <20060104010138.060c8a32@mango.fruits.de>
In-Reply-To: <1136314600.6039.174.camel@localhost.localdomain>
References: <20060103094720.GA16497@elte.hu>
	<20060103153317.26a512fa@mango.fruits.de>
	<20060103161356.4e1b47e0@mango.fruits.de>
	<1136313652.6039.171.camel@localhost.localdomain>
	<1136314600.6039.174.camel@localhost.localdomain>
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Jan 2006 13:56:40 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Well, with the patch, the above program has been running for over ten
> minutes without the race occurring.  Without the patch, the race happens
> in about one minute or less.

It has yet to show up here, too. Thanks, looks good.

Flo

-- 
Palimm Palimm!
http://tapas.affenbande.org
