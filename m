Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbTK1N45 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 08:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbTK1N45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 08:56:57 -0500
Received: from [65.248.4.67] ([65.248.4.67]:18582 "EHLO verdesmares.com")
	by vger.kernel.org with ESMTP id S262251AbTK1N44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 08:56:56 -0500
Message-ID: <001501c3b5b7$84c5bd20$34dfa7c8@bsb.virtua.com.br>
From: "Breno" <brenosp@brasilsec.com.br>
To: <linux-kernel@vger.kernel.org>,
       =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
References: <000701c3b5b3$addfbac0$34dfa7c8@bsb.virtua.com.br> <yw1xu14o1ub0.fsf@kth.se>
Subject: Re: Question - non-exec stack
Date: Fri, 28 Nov 2003 11:57:09 -0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes , 32 bit Intel processors

Breno
----- Original Message -----
From: "Måns Rullgård" <mru@kth.se>
To: <linux-kernel@vger.kernel.org>
Sent: Friday, November 28, 2003 11:44 AM
Subject: Re: Question - non-exec stack


"Breno" <brenosp@brasilsec.com.br> writes:

> I´d like to know  how non-exec stack can run on 32 bits processor. On
32bits
> processor vm_exec and vm_read has the same flags . So your tasks will not
> run very well.

This doesn't have anything to do with the CPU word size, does it?  I
guess you mean 32 bit Intel processors.

--
Måns Rullgård
mru@kth.se

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

