Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268128AbTBMWry>; Thu, 13 Feb 2003 17:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268309AbTBMWry>; Thu, 13 Feb 2003 17:47:54 -0500
Received: from [81.2.122.30] ([81.2.122.30]:28164 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S268128AbTBMWrx>;
	Thu, 13 Feb 2003 17:47:53 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302132258.h1DMwFtH024363@darkstar.example.net>
Subject: Re: 2.5.60 cheerleading...
To: Valdis.Kletnieks@vt.edu
Date: Thu, 13 Feb 2003 22:58:14 +0000 (GMT)
Cc: plars@linuxtestproject.org, linux-kernel@vger.kernel.org,
       edesio@task.com.br, torvalds@transmeta.com
In-Reply-To: <200302132220.h1DMKtFT011682@turing-police.cc.vt.edu> from "Valdis.Kletnieks@vt.edu" at Feb 13, 2003 05:20:55 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Since Linus hasn't chimed in yet, I'm guessing that's exactly what
> > happened.  I'm not trying to improve his workflow, but rather the
> > workflow of anyone who might be interested in getting more involved in
> > 2.5 testing.
> 
> What would help a lot of people (certainly me, at least), would be if
> somebody kept a well-publicized "already known errata" list along with
> (possibly unofficial) work-around patches.  Something along the line of:
> 
> compile fails in drivers/widget/fooby.c with error:
> undefined structure member 'blat' in line 1149.
> To fix:   apply <this patch>

Well, you can do that with my bug database - just open a new bug
report for each compile failiure, upload a patch to the database, and
link the patch with the new bug.  You can then collect together all
the relevant bug reports in to a confirmed bug for each kernel
version. You don't even have to duplicate bug reports if they occur in
multiple kernel versions.

John.
