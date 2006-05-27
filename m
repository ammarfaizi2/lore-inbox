Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964921AbWE0RZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964921AbWE0RZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 13:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbWE0RZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 13:25:58 -0400
Received: from wx-out-0102.google.com ([66.249.82.207]:63831 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964921AbWE0RZ5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 13:25:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tXfSwZ5eeC2pTHNO9Kl1FApstoxUtwZ7yqMfzrwU8w2iaEEU1ERAgaFhgaVWudZ3hT9LYcy2OgTAJRebJysW5il9Und1sFPY8YnTFvRKWD/LLBQS031RcT4a0SWdRX/RE3w4QOmyTwi4LZsJYpFbIRONtAtxfPvmnrAzfb2Q/PY=
Message-ID: <58d0dbf10605271025h5f79cec1u328d9cfb5fd51c5d@mail.gmail.com>
Date: Sat, 27 May 2006 19:25:57 +0200
From: "Jan Kiszka" <jan.kiszka@googlemail.com>
To: "Michael Opdenacker" <michael-lists@free-electrons.com>
Subject: Re: New Linux Cross Reference (LXR) site
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <44742166.20907@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <44742166.20907@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/5/24, Michael Opdenacker <michael-lists@free-electrons.com>:
> Hello,
>
> As the number of such sites is still very small, I set up a new LXR
> site: http://lxr.free-electrons.com/
>

You obviously use a quite recent lxr version. Which one? I have a
number of projects still referenced via lxr 0.3.1 because it's easy to
maintain and does not require a bunch of additional software. Maybe I
should really update...

Recently I started to experiment with OpenGrok
(http://www.opensolaris.org/os/project/opengrok), also for kernel
trees. Quite easy to handle, and I was enthusiastic about it first.
But it is not yet as robust as the lxr behind your site (reference
links are occasionally missing in the code), it's history mechanism is
not comparable to lxr's versioning, and arch-switching is lacking.

Jan
