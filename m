Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbTL2JOV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 04:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263057AbTL2JOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 04:14:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:41924 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263015AbTL2JOT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 04:14:19 -0500
Date: Mon, 29 Dec 2003 01:14:03 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
cc: mfedyk@matchmail.com, "Eric W. Biederman" <ebiederm@xmission.com>,
       Anton Ertl <anton@mips.complang.tuwien.ac.at>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, phillips@arcor.de
Subject: Re: Page Colouring (was: 2.6.0 Huge pages not working as expected)
In-Reply-To: <20031229065240.GU22443@holomorphy.com>
Message-ID: <Pine.LNX.4.58.0312290112450.11299@home.osdl.org>
References: <179fV-1iK-23@gated-at.bofh.it> <179IS-1VD-13@gated-at.bofh.it>
 <2003Dec27.212103@a0.complang.tuwien.ac.at> <Pine.LNX.4.58.0312271245370.2274@home.osdl.org>
 <m1smj596t1.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58.0312272046400.2274@home.osdl.org>
 <20031228163952.GQ22443@holomorphy.com> <20031229003631.GE1882@matchmail.com>
 <20031229025507.GT22443@holomorphy.com> <Pine.LNX.4.58.0312282000390.11299@home.osdl.org>
 <20031229065240.GU22443@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 28 Dec 2003, William Lee Irwin III wrote:
> 
> I did get a positive reaction from you at KS, and I've also been
> slaving away at keeping this thing current and improving it when I can
> for a year. Would you mind telling me what the Hell is going on here?
> 
> I guess I already know I'm screwed beyond all hope of recovery, but I
> might as well get official confirmation.

No, I haven't even _looked_ at any 2.7.x timeframe patches, and I'm not 
even going to for the next few months. 

I don't care what does it, I want a bigger PAGE_CACHE_SIZE, and working 
patches are the only thing that matters. But for now, I have my 2.6.x 
blinders on.

		Linus
