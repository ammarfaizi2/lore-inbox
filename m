Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262787AbTLIK6t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 05:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbTLIK6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 05:58:49 -0500
Received: from main.gmane.org ([80.91.224.249]:15066 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262762AbTLIK5v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 05:57:51 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: State of devfs in 2.6?
Date: Tue, 09 Dec 2003 11:57:48 +0100
Message-ID: <yw1xzne2gswj.fsf@kth.se>
References: <200312081536.26022.andrew@walrond.org> <200312081559.04771.andrew@walrond.org>
 <20031208233840.GD31370@kroah.com> <200312091037.20770.andrew@walrond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:MlrLU1CbC5xIlNK4+fchRSby+30=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Walrond <andrew@walrond.org> writes:

> My initial query has thrown up lots of interesting debate :)
>
> I, like most people I suspect, love the concept of a complete auto-populated 
> dev directory, and not having to MAKEDEV.

So do I.

> devfs provided this, but like most people who read LKML, I stopped using it 
> when it's problems were discussed.
>
> I really hope udev lives up to its promise, unlike devfs. Manually creating /
> dev just annoys me for no apparent reason other than it's plain inelegance I 
> suppose.

Does anyone else remember all the talk about the supreme elegance of
devfs back when it was new?

-- 
Måns Rullgård
mru@kth.se

