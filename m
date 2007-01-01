Return-Path: <linux-kernel-owner+w=401wt.eu-S932349AbXAAXfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbXAAXfd (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 18:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754771AbXAAXfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 18:35:33 -0500
Received: from smtp.osdl.org ([65.172.181.25]:46535 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754621AbXAAXfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 18:35:32 -0500
Date: Mon, 1 Jan 2007 15:34:53 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan <alan@lxorguk.ukuu.org.uk>
cc: Jeff Garzik <jgarzik@pobox.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Happy New Year (and v2.6.20-rc3 released)
In-Reply-To: <20070101213152.2cfc51c2@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0701011533360.4473@woody.osdl.org>
References: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org>
 <5a4c581d0701010528y3ba05247nc39f2ef096f84afa@mail.gmail.com>
 <Pine.LNX.4.64.0701011209140.4473@woody.osdl.org> <459973F6.2090201@pobox.com>
 <20070101213152.2cfc51c2@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 1 Jan 2007, Alan wrote:
>
> Want a fix Linus given Jeff is away ?

Send it over, and please cc Alessandro and others that can test it. Things 
obviously aren't broken on _my_ machines ;)

And if we end up having more problems related to this in -rc4, I'll just 
revert both your fix and the original one. No hair lost over this one, I 
think.

		Linus
