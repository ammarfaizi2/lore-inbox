Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbTK1JyS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 04:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbTK1JyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 04:54:18 -0500
Received: from main.gmane.org ([80.91.224.249]:49830 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262098AbTK1JyR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 04:54:17 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Strange behavior observed w.r.t 'su' command
Date: Fri, 28 Nov 2003 10:54:14 +0100
Message-ID: <yw1xad6g3jjt.fsf@kth.se>
References: <20031128093929.13486.qmail@web40909.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:dPfv0e7hN0FfzhCcgYUgyQ9UGfQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bradley Chapman <kakadu_croc@yahoo.com> writes:

> Confirmed. I have a Red Hat 9 system running 2.6.0-test11 with glibc
> 2.3.2-82 and coreutils 4.5.3-19.0.2. Killing su with SIGKILL does
> put the keyboard into unbuffered mode and does alternate the
> prompts. No error messages appear in dmesg.

Does anyone know why redhat keeps doing these strange modifications?
Over the years, I've encountered quite a few problems caused by redhat
messing things up.  A few examples:

- gcc 2.96
- A rather recent redhat version shipped with a broken 'sort'
  command.  It performed a seemingly random permutation.
- Redhat 9 perl doesn't treat rexexps the same way a clean perl of the
  same version does.

Anyway, I guess it could be over soon, if only people would understand
to stay away from that fedora stuff.

-- 
Måns Rullgård
mru@kth.se

