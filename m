Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbTISILY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 04:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbTISILY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 04:11:24 -0400
Received: from main.gmane.org ([80.91.224.249]:61677 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261434AbTISILX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 04:11:23 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: How does one get paid to work on the kernel?
Date: Fri, 19 Sep 2003 10:10:46 +0200
Message-ID: <yw1xu179mc55.fsf@users.sourceforge.net>
References: <1063915370.2410.12.camel@laptop-linux> <yw1xad91nrmd.fsf@users.sourceforge.net>
 <1063958370.5520.6.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:qZDhsvdjoMmHRjpFq4YqBHJk3KA=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham <ncunningham@clear.net.nz> writes:

> There is support in the current kernel for Software Suspend, but the 2.4
> version contains a lot of extra functionality that isn't present in 2.6
> at the moment. (Support for HighMem, swap files, asynchronous I/O, a
> nicer user interface, compression...).

I see.  BTW, is it possible to boot normally, and later resume from
the saved state, provided you don't touch any filesystems or swap
areas involved in the suspend?  I seem to recall reading somewhere
that it would be possible, but I can't find any information on how to
do it.

-- 
Måns Rullgård
mru@users.sf.net

