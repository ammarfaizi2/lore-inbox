Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262020AbVADVI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbVADVI1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 16:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261945AbVADVIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 16:08:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:46269 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261869AbVADVFh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 16:05:37 -0500
Date: Tue, 4 Jan 2005 13:05:29 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] disallow modular capabilities
In-Reply-To: <1104870292.8346.24.camel@krustophenia.net>
Message-ID: <Pine.LNX.4.58.0501041303190.2294@ppc970.osdl.org>
References: <20050102200032.GA8623@lst.de> <1104870292.8346.24.camel@krustophenia.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 4 Jan 2005, Lee Revell wrote:
> 
> And I posted this to LKML almost a week ago, and a real fix was posted
> in response.
> 
> http://lkml.org/lkml/2004/12/28/112

Well, I realize that it has been on bugtraq, but does that make it a real 
concern? I'll make the tristate a boolean, but has anybody half-way sane 
ever _done_ what is described by the bugtraq posting? IOW, it looks pretty 
much like a made-up example, also known as a "don't do that then" kind of 
buglet ;)

		Linus
