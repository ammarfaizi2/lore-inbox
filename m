Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261553AbUJ0Avc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbUJ0Avc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 20:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbUJ0Avc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 20:51:32 -0400
Received: from smtp-out-02.utu.fi ([130.232.202.172]:5051 "EHLO
	smtp-out-02.utu.fi") by vger.kernel.org with ESMTP id S261553AbUJ0AvS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 20:51:18 -0400
Date: Wed, 27 Oct 2004 03:51:09 +0300
From: Jan Knutar <jk-lkml@sci.fi>
Subject: Re: Let's make a small change to the process
In-reply-to: <4d8e3fd304102613447c0156b2@mail.gmail.com>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Cc: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Randy.Dunlap" <rddunlap@osdl.org>, alan@lxorguk.ukuu.org.uk,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <200410270351.09581.jk-lkml@sci.fi>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.6.2
References: <200410260644.47307.edt@aei.ca> <20041026203644.GD2307@redhat.com>
 <4d8e3fd304102613447c0156b2@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 October 2004 23:44, Paolo Ciarrocchi wrote:

> If the goal of -ac is to only include those fixes, why can't we rename
> it in something more "intuitive" for the final users ?
> Do you see what I mean ?

"Final users" are those like me, who so far are quite satisfied[1] with the
distribution kernel. Advanced users will be aware of the existence of
other than kernel.org versions of the kernel, and will hopefully be able
to pick one suited to their particular fuzzy feelings. 

During 2.4 development (IIRC) it was somewhat fairly generic knowledge
amongst those who had progressed marginally beyond booting linux, to
compiling some kernel from sources, what -ac postfix meant. Why that
sort of community knowledge osmosis wouldn't be possible or active today
also, I do not know. Perhaps people are just in general afraid of change.


[1] As in, the Fedora Core 2 kernel did not immediately give me such awful
performance that it made me get a kernel.org kernel to get back the magnitude
or so performance loss of the typical Redhat9 kernel. Benchmarks purely
subjective of course, sorry. :-/
