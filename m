Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263294AbTJZQfd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 11:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263299AbTJZQfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 11:35:33 -0500
Received: from cambridge.merl.com ([137.203.190.1]:8928 "EHLO
	cambridge.merl.com") by vger.kernel.org with ESMTP id S263294AbTJZQfa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 11:35:30 -0500
Date: Sun, 26 Oct 2003 11:35:29 -0500
Message-Id: <200310261635.h9QGZTe13121@localhost.localdomain>
From: <wsy@merl.com>
To: marco.roeland@xs4all.nl
CC: linux-kernel@vger.kernel.org
In-reply-to: <20031026162422.GB23792@localhost> (message from Marco Roeland on
	Sun, 26 Oct 2003 17:24:22 +0100)
Subject: Re: compile-time error in 2.6.0-test9
References: <200310261553.h9QFrb513039@localhost.localdomain> <20031026162422.GB23792@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OK, I will put that patch in.

Thanks!  

(and hmmm... maybe it _is_ time to upgrade gcc.  Looking at the
problems with long long unsigneds, that looks awfully familiar with a
mailfiltering app I am coding that got GCC very wierded out.  I
thought it was just my l33t ex-FORTRAN-hack coding style that was the
bug cause.  :-) ).

What's the recommended version of GCC these days?

       -Bill Yerazunis
