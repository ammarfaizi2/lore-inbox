Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbUA0R46 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 12:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbUA0R46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 12:56:58 -0500
Received: from main.gmane.org ([80.91.224.249]:45213 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261606AbUA0R44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 12:56:56 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: GPL license and linux kernel modifications
Date: Tue, 27 Jan 2004 18:56:53 +0100
Message-ID: <yw1xoespz34q.fsf@kth.se>
References: <E1AlW2F-000N9k-00.bansh21-mail-ru@f13.mail.ru> <401692E2.7010800@backtobasicsmgmt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:EFSEg9egs85oUMFpo0d72OzKXbk=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com> writes:

> Bansh wrote:
>
>> special exception, the source code distributed need not include
>> anything that is normally distributed (in either source or binary
>> form) with the major components (compiler, kernel, and so on) of the
>> operating system on which the executable runs, unless that component
>> itself accompanies the executable.
>> ----------- cut COPYING -----------
>> It gives the possibility to not distribute compiler and other
>> preprocessing tools.
>> It looks like one can make a preprocessor or even one's own
>> compiler (with one's syntax) which will be used for kernel
>> building. But it's not required to distribute this compiler. So I
>> can distribute linux kernel source code modified this way but no
>> one will be able to build it. Is it ok?
>
> Only if those "compiler and other preprocessing tools" are normally
> distributed with the O/S the executable runs on. If you create your
> own compiler, and it's not "normally distributed", then you can't
> publish source code in that language under the GPL without making the
> compiler available as well.

Yes, you can, at least if you own the source code in question.  It
becomes more unclear when you take someone else's GPL'd code and
modify it to only work with your private compiler.

-- 
Måns Rullgård
mru@kth.se

