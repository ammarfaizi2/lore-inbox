Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266130AbUAQTSJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 14:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266134AbUAQTSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 14:18:09 -0500
Received: from main.gmane.org ([80.91.224.249]:51625 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266130AbUAQTR7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 14:17:59 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: 2.6.1 rocks :)
Date: Sat, 17 Jan 2004 20:17:56 +0100
Message-ID: <yw1xvfnao04b.fsf@ford.guide>
References: <40097FB4.5090804@milent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:giusNm58cWTDMhtWzjL8AaaHI0k=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Markley <alex@milent.com> writes:

>  >>(The ehci-hcd module still locks the kernel immediately tho.) :(
>
>  >Do submit a proper bug report for that.  FWIW, it works well for me.
>
> Yeah, I've submitted bugreports regarding this bug a few times. (It's
> been broken as long as I can remember.) The general consensus is
> basically that my intel-based USB2 hardware is just too buggy or
> something. :(

Get a NEC chip based USB2 controller instead.

-- 
Måns Rullgård
mru@kth.se

