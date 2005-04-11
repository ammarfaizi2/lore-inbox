Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261938AbVDKVYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbVDKVYP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 17:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261949AbVDKVYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 17:24:14 -0400
Received: from fire.osdl.org ([65.172.181.4]:23229 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261938AbVDKVYM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 17:24:12 -0400
Date: Mon, 11 Apr 2005 14:26:06 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <greg@kroah.com>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: New SCM and commit list
In-Reply-To: <20050411205317.GA26246@kroah.com>
Message-ID: <Pine.LNX.4.58.0504111424270.1267@ppc970.osdl.org>
References: <1113174621.9517.509.camel@gaston> <Pine.LNX.4.58.0504101621200.1267@ppc970.osdl.org>
 <1113189922.9899.6.camel@mulgrave> <20050411205317.GA26246@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Apr 2005, Greg KH wrote:
> 
> I have a feeling that the kernel.org mirror system is just going to
> _love_ us using it to store temporary git trees :)

I don't think kernel.org mirrors the private home directories, so it you
do _temporary_ trees, just make them readable in your private home
directory rather than in /pub/linux/kernel/people. For people with 
kernel.org accounts, we can use that as the "bkbits.net" thing.

For really public hosting, we need to find some other approach. 

		Linus
