Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264672AbTFENnH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 09:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264675AbTFENnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 09:43:06 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:31236 "EHLO smtp.uc3m.es")
	by vger.kernel.org with ESMTP id S264672AbTFENnD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 09:43:03 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200306051356.h55DuSP17808@oboe.it.uc3m.es>
Subject: Re: sleep under spinlock detection
To: linux kernel <linux-kernel@vger.kernel.org>
Date: Thu, 5 Jun 2003 15:56:28 +0200 (MET DST)
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Dave Jones wrote:"
> On Thu, Jun 05, 2003 at 02:05:09PM +0200, Peter T. Breuer wrote:
>  > I've put a prototype c-code analyser on the net at
>  > 
>  >  ftp://oboe.it.uc3m.es/pub/Programs/c-1.0.tgz
> 
> --15:06:22--  ftp://oboe.it.uc3m.es/pub/Programs/c-1.0.tgz
>            => `c-1.0.tgz'
> Resolving oboe.it.uc3m.es... done.
> Connecting to oboe.it.uc3m.es[163.117.139.101]:21... connected.
> Logging in as anonymous ... Logged in!
> ==> SYST ... done.    ==> PWD ... done.
> ==> TYPE I ... done.  ==> CWD /pub/Programs ... done.
> ==> PASV ... done.    ==> RETR c-1.0.tgz ... 
> No such file `c-1.0.tgz'.

Sorry about that - lunch error. Now there.

 oboe:/home/ftp/pub/Programs% ls -l c-1.0.tgz 
 -rw-r--r--   1 root     prof        90617 Jun  5 15:17 c-1.0.tgz


Peter
