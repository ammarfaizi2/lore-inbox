Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262377AbTINMNi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 08:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262379AbTINMNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 08:13:38 -0400
Received: from dsl092-073-159.bos1.dsl.speakeasy.net ([66.92.73.159]:47118
	"EHLO yupa.krose.org") by vger.kernel.org with ESMTP
	id S262377AbTINMNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 08:13:38 -0400
To: Oleg Drokin <green@namesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Large-file corruption. ReiserFS? VFS?
References: <87r82noyr9.fsf@nausicaa.krose.org>
	<20030912153935.GA2693@namesys.com>
X-Home-Page: http://www.krose.org/~krose/
From: Kyle Rose <krose+linux-kernel@krose.org>
Organization: krose.org
Content-Type: text/plain; charset=US-ASCII
Date: Sun, 14 Sep 2003 08:13:27 -0400
In-Reply-To: <20030912153935.GA2693@namesys.com> (Oleg Drokin's message of
 "Fri, 12 Sep 2003 19:39:35 +0400")
Message-ID: <87pti3muu0.fsf@nausicaa.krose.org>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) XEmacs/21.4 (Rational FORTRAN,
 i386-debian-linux)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You are absolutely right.
> Ther is a reiserfs problem that I just found based on your description.
> The patch below should help. Please confirm that it works for you too.
> Thanks a lot for the report.

This indeed solves the problem.  Thanks, Oleg!

Cheers,
Kyle
