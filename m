Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269542AbTGUJnB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 05:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269557AbTGUJnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 05:43:01 -0400
Received: from coral.ocn.ne.jp ([211.6.83.180]:54210 "EHLO
	smtp.coral.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S269542AbTGUJm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 05:42:59 -0400
Date: Mon, 21 Jul 2003 18:57:59 +0900
From: Bruce Harada <bharada@coral.ocn.ne.jp>
To: zolw@wombb.edu.pl
Cc: linux-kernel@vger.kernel.org
Subject: Re: problem linux-2.6.0-test1 on alpha
Message-Id: <20030721185759.1d8da19f.bharada@coral.ocn.ne.jp>
In-Reply-To: <20030721110934.0aa1aaeb.zolw@wombb.edu.pl>
References: <vines.sxdD+Gjg4zA@SZKOM.BFS.DE>
	<20030721110934.0aa1aaeb.zolw@wombb.edu.pl>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jul 2003 11:09:34 +0200
> Dnia Sun, 20 Jul 2003 19:05:23 +0200
> 
> > I have tried 2.12,2.13,2.14 sofar, no success at all. did anyone else
> > tried 2.6 on alpha ?
> 
> builds and works:
> [root@pldmachine /root]# rpm -q gcc binutils modutils module-init-tools
> gcc-3.3-3
> binutils-2.14.90.0.4.1-1
> modutils-2.4.25-4
> module-init-tools-0.9.12-0.2
> [root@pldmachine /root]# uname -a
> Linux pldmachine 2.6.0 #1 Wed Jul 16 13:34:25 CEST 2003 alpha EV56
> unknown PLD Linux

Just as a matter of interest, what distribution are you running on that?

