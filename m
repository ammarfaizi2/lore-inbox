Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264455AbUBIJMw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 04:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264450AbUBIJMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 04:12:46 -0500
Received: from smtpde03.sap-ag.de ([155.56.68.171]:19938 "EHLO
	smtpde03.sap-ag.de") by vger.kernel.org with ESMTP id S264444AbUBIJMo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 04:12:44 -0500
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: tmpfs sparse file failure in glibc "make check"
References: <1jKa4-1TZ-17@gated-at.bofh.it> <1jKjY-27v-35@gated-at.bofh.it>
From: Christoph Rohland <cr@sap.com>
Message-ID: <ovr7xa3awq.fsf@sap.com>
Organization: SAP Java Server Technology
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Rational FORTRAN,
 cygwin32)
Content-Type: text/plain; charset=us-ascii
Cancel-Lock: sha1:/efTNZPGyA4jbT1VN/HXLYIlAC4=
Date: Mon, 09 Feb 2004 10:12:43 +0100
MIME-Version: 1.0
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On Fri, 30 Jan 2004, Kevin P. Fleming wrote:
> what is the real advantage of both functions being performed by the
> same code?

Less is more? Keep it simple and stupid? You need only one maintainer
and he can additionally work on something different? You do not have
to fix bugs twice? Architectural cleanliness?

Pick (at least) one. I would pick all of them!

Greetings
		Christoph


