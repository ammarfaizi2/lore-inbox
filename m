Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbUJWPU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbUJWPU0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 11:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbUJWPU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 11:20:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36003 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261155AbUJWPUV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 11:20:21 -0400
Date: Sat, 23 Oct 2004 11:20:18 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Karel Kulhavy <clock@twibright.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Writing linux kernel specification
In-Reply-To: <20041023133944.GA1204@beton.cybernet.src>
Message-ID: <Pine.LNX.4.44.0410231118570.25612-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Oct 2004, Karel Kulhavy wrote:

> 3) Is Linux kernel meant to have a specification and just a lack of time
>    prevented it, or is Linux kernel meant to not have a specification?
> 4) If I produce a specification that is valid, correct and complete enough
>    to be useful for general public, will it be included on the Linux kernel
>    homepage http://www.kernel.org under a link "Linux kernel official
>    specification" upon my request?

You can write a specification, but I can guarantee you that
it will be out of date the moment you run your spell checker
on it.

Linux kernel development continues at a very high speed, and
things inside the kernel change all the time.  The only thing
that's stable is the user space ABI (the system calls), since
the behaviour of those (mostly) follows POSIX and the Single
Unix Standard (SUS).

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

