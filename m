Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262616AbVA0SlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262616AbVA0SlA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 13:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262626AbVA0Sk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 13:40:59 -0500
Received: from smtpout.mac.com ([17.250.248.84]:3557 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262611AbVA0Skp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 13:40:45 -0500
In-Reply-To: <41F92D2B.4090302@comcast.net>
References: <20050127101117.GA9760@infradead.org> <20050127101322.GE9760@infradead.org> <41F92721.1030903@comcast.net> <1106848051.5624.110.camel@laptopd505.fenrus.org> <41F92D2B.4090302@comcast.net>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7ef2988faa74dfdd5da02be1cd891a25@mac.com>
Content-Transfer-Encoding: 7bit
Cc: akpm@osdl.org, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
From: Felipe Alfaro Solana <lkml@mac.com>
Subject: Re: Patch 4/6  randomize the stack pointer
Date: Thu, 27 Jan 2005 19:40:40 +0100
To: John Richard Moser <nigelenki@comcast.net>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Jan 2005, at 19:04, John Richard Moser wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> What the hell?
>
> So instead of bringing something in that works, you bring something in
> that does significantly less, and gives no savings on overhead or patch
> complexity why?  So you can later come out and say "We're so great now
> we've increased the randomization by tweaking one variable aren't we
> cool!!!"?
>
> Red Hat is all smoke and mirrors anyway when it comes to security, just
> like Microsoft.  This just reaffirms that.

Please, keep politics out of this list and, instead, keep contributing 
with practical ideas and code.

