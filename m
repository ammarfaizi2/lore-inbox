Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265478AbUBAVKu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 16:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265515AbUBAVKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 16:10:50 -0500
Received: from main.gmane.org ([80.91.224.249]:59272 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265478AbUBAVKl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 16:10:41 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Unrecognizable insn
Date: Sun, 01 Feb 2004 21:55:52 +0100
Message-ID: <yw1x8yjmplif.fsf@kth.se>
References: <20040201204143.GA26961@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ti200710a080-2939.bb.online.no
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:CfbuRotgLTegylOa5UwkUz+ZiDU=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl <herbert@13thfloor.at> writes:

> Hi!
>
> anybody seen that before?
>
> fs/proc/array.c: In function `proc_pid_stat':
> fs/proc/array.c:441: Unrecognizable insn:
>
> gcc version 2.96 20000731 (Mandrake Linux 8.2 2.96-0.76mdk)

That version is quite likely to produce any possible error and then
some.  Get gcc 3.3.

-- 
Måns Rullgård
mru@kth.se

