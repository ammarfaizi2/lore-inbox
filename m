Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424368AbWKJGZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424368AbWKJGZl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 01:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966098AbWKJGZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 01:25:41 -0500
Received: from wx-out-0506.google.com ([66.249.82.236]:14329 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S966097AbWKJGZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 01:25:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=agyyOSDKXnWKw0e4gLq4p5rbKekRX2SMI7mjiExLKbsnmIiN//vywfsnUJI6qATOylMDtr2Tv3GKBdaORq7Bc+tRWPmB5MuA0LwcbxV5BPKPiAgSHbrwyZq/euS4nC1VwIlmr4w4U+++BbOesDjCRjkb3BywCMLUF/XYuMGmjD0=
Message-ID: <b6a2187b0611092225m47378626oe62b0466d904abbd@mail.gmail.com>
Date: Fri, 10 Nov 2006 14:25:30 +0800
From: "Jeff Chua" <jeff.chua.linux@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: [discuss] Re: 2.6.19-rc4: known unfixed regressions (v3)
Cc: "Adrian Bunk" <bunk@stusta.de>, "Matthew Wilcox" <matthew@wil.cx>,
       "Andi Kleen" <ak@suse.de>, "Aaron Durbin" <adurbin@google.com>,
       "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <Pine.LNX.4.64.0611081010120.3667@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0611080056480.12828@silvia.corp.fedex.com>
	 <20061107171143.GU27140@parisc-linux.org>
	 <200611080839.46670.ak@suse.de>
	 <20061108122237.GF27140@parisc-linux.org>
	 <Pine.LNX.4.64.0611080803280.3667@g5.osdl.org>
	 <20061108172650.GC4729@stusta.de>
	 <Pine.LNX.4.64.0611080932320.3667@g5.osdl.org>
	 <Pine.LNX.4.64.0611080951040.3667@g5.osdl.org>
	 <Pine.LNX.4.64.0611081010120.3667@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/06, Linus Torvalds <torvalds@osdl.org> wrote:

> Pushed out. Jeff, can you verify that current git does the right thing.

Linus,

Can you post those affected patches that I can apply directly to 2.6.19-rc5?

I'm still old-fashioned and have not downloaded the git dist. I'll try
to do that  tonight.

Currently, I'm using Aaron Durbin's patch and it works.

Thanks,
Jeff.
