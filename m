Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbUBGXRD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 18:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbUBGXRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 18:17:03 -0500
Received: from main.gmane.org ([80.91.224.249]:40580 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261411AbUBGXRB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 18:17:01 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: cpufreq - less possible freqs with 2.6.2 and P4M
Date: Sun, 08 Feb 2004 00:16:58 +0100
Message-ID: <yw1xd68q4h05.fsf@kth.se>
References: <402562D4.7010706@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ti200710a080-1862.bb.online.no
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:k0BMhsvzgQF1g10Wlt9ouKSPKQk=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Georg Müller <georgmueller@gmx.net> writes:

> Hi,
>
> I have a Pentium 4M at 1.8GHz.
> With 2.6.0 it was possible to slow down my CPU in several steps down
> to 200MHz via cpufreq.
> With 2.6.2 I can only switch between 1.2 and 1.8GHz (as it was with
> 2.4 too).

Which cpufreq module are you using?  With p4-clockmod I get lots of
choices, with acpi only the two you mentioned.

-- 
Måns Rullgård
mru@kth.se

