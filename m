Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264010AbUDFU4p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 16:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264009AbUDFUyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 16:54:00 -0400
Received: from mail-ext.curl.com ([66.228.88.132]:28676 "HELO
	mail-ext.curl.com") by vger.kernel.org with SMTP id S264008AbUDFUxa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 16:53:30 -0400
To: Timothy Miller <miller@techsource.com>
Cc: Jesse Pollard <jesse@cats-chateau.net>, linux-kernel@vger.kernel.org
Subject: Re: kernel stack challenge
References: <20040405234957.69998.qmail@web40509.mail.yahoo.com>
	<20040406132750$3d4e@grapevine.lcs.mit.edu>
	<s5gisgd9ipj.fsf@patl=users.sf.net> <407300C3.9050109@techsource.com>
From: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Message-ID: <s5gd66kamde.fsf@patl=users.sf.net>
Date: 06 Apr 2004 16:53:29 -0400
In-Reply-To: <407300C3.9050109@techsource.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller <miller@techsource.com> writes:

> I think 100K is rather large for an interpretor to be included in the
> kernel, but putting that aside...

I think we are all putting that aside for the moment.  :-)

> It's a limited number of people who would actually write these
> policies. If those people follow certain coding rules, then we CAN
> have such bounds, by convention.  Yes, those bounds could be violated,
> but if the programmer (not sysadmin -- they would never write these
> things in LISP) breaks something, it's just a bug.

Fair enough.  But then I wonder how many of Lisp's advantages you
would lose.  I am having trouble imagining "statically bounded Lisp"
without being so stylized as to hardly be Lisp at all.

 - Pat
