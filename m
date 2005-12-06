Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964896AbVLFBTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964896AbVLFBTh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 20:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbVLFBTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 20:19:36 -0500
Received: from mail.enyo.de ([212.9.189.167]:41674 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S964896AbVLFBTf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 20:19:35 -0500
From: Florian Weimer <fw@deneb.enyo.de>
To: Greg KH <greg@kroah.com>
Cc: "M." <vo.sinh@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
References: <20051203135608.GJ31395@stusta.de>
	<9a8748490512030629t16d0b9ebv279064245743e001@mail.gmail.com>
	<20051203201945.GA4182@kroah.com>
	<f0cc38560512031254j3b28d579s539be721c247c10a@mail.gmail.com>
	<20051203211209.GA4937@kroah.com>
Date: Tue, 06 Dec 2005 02:19:29 +0100
In-Reply-To: <20051203211209.GA4937@kroah.com> (Greg KH's message of "Sat, 3
	Dec 2005 13:12:09 -0800")
Message-ID: <87y82z10pq.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg KH:

>> Yes but not home users with relatively new/bleeding edge hardware or
>> small projects writing for example a wifi driver or a security patch
>> or whatever without full time commitment to tracking kernel changes.
>
> If you are a user that wants this kind of support, then use a distro
> that can handle this.  Obvious examples that come to mind are both
> Debian and Gentoo and Fedora and OpenSuSE, and I'm sure there are
> others.

IIRC, Gentoo ignores some kinds of security bugs so that the task
remains manageable.  Debian, in contrast, hasn't released a kernel
update for its stable distribution since June (but unstable and even
testing is in surprisingly good shape).

Maybe the real vendor kernels are better.  Without CVE-based bug
tracking on their part, it is hard to tell, though. 8-)
