Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262223AbVATQuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262223AbVATQuH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 11:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbVATQrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 11:47:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:45017 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262290AbVATQlG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 11:41:06 -0500
Date: Thu, 20 Jan 2005 08:40:42 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
cc: Janos Farkas <jf-ml-k1-1087813225@lk8rp.mail.xeon.eu.org>,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Chris Bruner <cryst@golden.net>, Andrew Morton <akpm@osdl.org>,
       Matt Domsch <Matt_Domsch@dell.com>
Subject: Re: COMMAND_LINE_SIZE increasing in 2.6.11-rc1-bk6
In-Reply-To: <20050120162807.GA3174@stusta.de>
Message-ID: <Pine.LNX.4.58.0501200840170.8178@ppc970.osdl.org>
References: <20050119231322.GA2287@lk8rp.mail.xeon.eu.org>
 <20050120162807.GA3174@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Jan 2005, Adrian Bunk wrote:
>
> On Thu, Jan 20, 2005 at 12:13:22AM +0100, Janos Farkas wrote:
> > 
> > Isn't this define a lilo dependence?
> 
> AOL:
> - lilo 22.6.1
> - CONFIG_EDD=y
> - 2.6.10-mm1 and 2.6.11-rc1 did boot
> - 2.6.11-rc1-mm1 and 2.6.11-rc1-mm2 didn't boot
> - 2.6.11-rc1-mm2 with this ChangeSet reverted boots.

Thanks. Reverted.

		Linus
