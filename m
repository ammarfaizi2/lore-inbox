Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbTJULku (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 07:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263061AbTJULku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 07:40:50 -0400
Received: from main.gmane.org ([80.91.224.249]:25788 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263015AbTJULkt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 07:40:49 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [2.6.0-test8] Difference between Software Suspend and
 Suspend-to-disk?
Date: Tue, 21 Oct 2003 13:40:44 +0200
Message-ID: <yw1xy8veddj7.fsf@kth.se>
References: <200310211315.58585.lkml@kcore.org> <20031021113444.GC9887@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:c667u1DquqN1SpfIWS94EDiTOYY=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Szepe <szepe@pinerecords.com> writes:

>> Software Suspend (EXPERIMENTAL)
>> Suspend-to-Disk Support
>
> They're competing implementations of the same mechanism.

And neither one works reliably, I might add.  They both appear to save
the current state to disk, but no matter what I try, I can't make it
resume properly.

-- 
Måns Rullgård
mru@kth.se

