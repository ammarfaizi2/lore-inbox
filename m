Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266252AbUHJOy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266252AbUHJOy0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 10:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266258AbUHJOy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 10:54:26 -0400
Received: from pop.gmx.de ([213.165.64.20]:41907 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266252AbUHJOyX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 10:54:23 -0400
X-Authenticated: #4399952
Date: Tue, 10 Aug 2004 17:04:27 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O4
Message-Id: <20040810170427.46eaa186@mango.fruits.de>
In-Reply-To: <1092147415.5818.2.camel@mindpipe>
References: <1090832436.6936.105.camel@mindpipe>
	<20040726124059.GA14005@elte.hu>
	<20040726204720.GA26561@elte.hu>
	<20040729222657.GA10449@elte.hu>
	<20040801193043.GA20277@elte.hu>
	<20040809104649.GA13299@elte.hu>
	<20040809130558.GA17725@elte.hu>
	<20040809190201.64dab6ea@mango.fruits.de>
	<1092103522.761.2.camel@mindpipe>
	<1092117141.761.15.camel@mindpipe>
	<20040810075331.GB25238@elte.hu>
	<1092147415.5818.2.camel@mindpipe>
X-Mailer: Sylpheed-Claws 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2004 10:16:55 -0400
Lee Revell <rlrevell@joe-job.com> wrote:

> On Tue, 2004-08-10 at 03:53, Ingo Molnar wrote:
> > can you trigger similar latencies via the attached mlock testcode?
> > (written by Florian. Run it as root.)
> > 
> 
> Yup, using only 100000 bytes, I get a bunch of these:

Hi, just to make sure: Those weren't 100000 kbytes actually?

Flo

-- 
Palimm Palimm!
http://affenbande.org/~tapas/

