Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbTK1Noz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 08:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262224AbTK1Noz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 08:44:55 -0500
Received: from main.gmane.org ([80.91.224.249]:57512 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262198AbTK1Noy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 08:44:54 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Question - non-exec stack
Date: Fri, 28 Nov 2003 14:44:51 +0100
Message-ID: <yw1xu14o1ub0.fsf@kth.se>
References: <000701c3b5b3$addfbac0$34dfa7c8@bsb.virtua.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:zuaVjU1pAgX/naP7R2LZ94uwrNQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Breno" <brenosp@brasilsec.com.br> writes:

> I´d like to know  how non-exec stack can run on 32 bits processor. On 32bits
> processor vm_exec and vm_read has the same flags . So your tasks will not
> run very well.

This doesn't have anything to do with the CPU word size, does it?  I
guess you mean 32 bit Intel processors.

-- 
Måns Rullgård
mru@kth.se

