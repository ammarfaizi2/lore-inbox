Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266333AbUHJPIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266333AbUHJPIl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 11:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266910AbUHJPIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 11:08:41 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:9186 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266333AbUHJPIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 11:08:32 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O4
From: Lee Revell <rlrevell@joe-job.com>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040810170427.46eaa186@mango.fruits.de>
References: <1090832436.6936.105.camel@mindpipe>
	 <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu>
	 <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu>
	 <20040809104649.GA13299@elte.hu> <20040809130558.GA17725@elte.hu>
	 <20040809190201.64dab6ea@mango.fruits.de> <1092103522.761.2.camel@mindpipe>
	 <1092117141.761.15.camel@mindpipe> <20040810075331.GB25238@elte.hu>
	 <1092147415.5818.2.camel@mindpipe>
	 <20040810170427.46eaa186@mango.fruits.de>
Content-Type: text/plain
Message-Id: <1092150530.10794.0.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 10 Aug 2004 11:08:50 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-10 at 11:04, Florian Schmidt wrote:
> On Tue, 10 Aug 2004 10:16:55 -0400
> Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > On Tue, 2004-08-10 at 03:53, Ingo Molnar wrote:
> > > can you trigger similar latencies via the attached mlock testcode?
> > > (written by Florian. Run it as root.)
> > > 
> > 
> > Yup, using only 100000 bytes, I get a bunch of these:
> 
> Hi, just to make sure: Those weren't 100000 kbytes actually?
> 

Oops, 100000KB.

Lee

