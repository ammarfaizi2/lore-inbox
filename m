Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132256AbRAXA4R>; Tue, 23 Jan 2001 19:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132228AbRAXA4J>; Tue, 23 Jan 2001 19:56:09 -0500
Received: from iq.sch.bme.hu ([152.66.226.168]:31785 "EHLO iq.rulez.org")
	by vger.kernel.org with ESMTP id <S132256AbRAXAz6>;
	Tue, 23 Jan 2001 19:55:58 -0500
Date: Wed, 24 Jan 2001 01:58:51 +0100 (CET)
From: Sasi Peter <sape@iq.rulez.org>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <93t1q7$49c$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.30.0101240156150.3522-100000@iq.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Jan 2001, Linus Torvalds wrote:

> The only obvious use for it is file serving, and as high-performance
> file serving tends to end up as a kernel module in the end anyway (the
> only hold-out is samba, and that's been discussed too), "sendfile()"
> really is more a proof of concept than anything else.

No plans for samba to use sendfile? Even better make it a tux-like module?
(that would enable Netware-Linux like performance with the standard
kernel... would be cool afterall ;)


-- 
SaPE - Peter, Sasi - mailto:sape@sch.hu - http://sape.iq.rulez.org/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
