Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261894AbTILVFg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 17:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbTILVFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 17:05:36 -0400
Received: from dsl092-073-159.bos1.dsl.speakeasy.net ([66.92.73.159]:54029
	"EHLO yupa.krose.org") by vger.kernel.org with ESMTP
	id S261894AbTILVFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 17:05:33 -0400
To: Oleg Drokin <green@namesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Large-file corruption. ReiserFS? VFS?
References: <87r82noyr9.fsf@nausicaa.krose.org>
	<20030912153935.GA2693@namesys.com>
	<20030912175917.GB30584@matchmail.com>
	<20030912184001.GA9245@namesys.com>
	<20030912205446.GD30584@matchmail.com>
X-Home-Page: http://www.krose.org/~krose/
From: Kyle Rose <krose+linux-kernel@krose.org>
Organization: krose.org
Content-Type: text/plain; charset=US-ASCII
Date: Fri, 12 Sep 2003 17:05:24 -0400
In-Reply-To: <20030912205446.GD30584@matchmail.com> (Mike Fedyk's message of
 "Fri, 12 Sep 2003 13:54:46 -0700")
Message-ID: <87ekylg1kb.fsf@nausicaa.krose.org>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) XEmacs/21.4 (Rational FORTRAN,
 i386-debian-linux)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does this affect 2.4 also?

As I said, this did not affect 2.4, at least not uniformly: I
regularly created DVD ISO images larger than 4GB under 2.4.2{0,1,2}
without problems.

Cheers,
Kyle
