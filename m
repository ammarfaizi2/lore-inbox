Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264040AbTJ1Qvw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 11:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264041AbTJ1Qvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 11:51:52 -0500
Received: from main.gmane.org ([80.91.224.249]:30645 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264040AbTJ1Qvv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 11:51:51 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [PATCH] Autoregulate vm swappiness cleanup
Date: Tue, 28 Oct 2003 17:51:48 +0100
Message-ID: <yw1xy8v54863.fsf@kth.se>
References: <3F9E707B.7030609@freemail.hu> <Pine.LNX.4.53.0310280936550.20004@chaos>
 <200310281539.h9SFdixF024951@turing-police.cc.vt.edu>
 <Pine.LNX.4.53.0310281048130.21561@chaos>
 <200310281637.h9SGb5xF026894@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:OxGF1nI+No0Jv3XaKCSk2doACqY=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu writes:

> And I'm *positive* that *nobody* on this list has done that,
> forgotten to rename the variables, and then wondered why module1 has
> 'debug_level = 1;' in it and the debugging output starts and then
> mysteriously stops some random time after (because module2 has
> 'debug_level = 0;' in it...)

Doing that mistake would give a linker error.

-- 
Måns Rullgård
mru@kth.se

