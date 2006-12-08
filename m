Return-Path: <linux-kernel-owner+w=401wt.eu-S1425611AbWLHQo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425611AbWLHQo3 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 11:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425617AbWLHQo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 11:44:29 -0500
Received: from iabervon.org ([66.92.72.58]:2278 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425611AbWLHQo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 11:44:28 -0500
Date: Fri, 8 Dec 2006 11:44:27 -0500 (EST)
From: Daniel Barkalow <barkalow@iabervon.org>
To: Jeff Garzik <jeff@garzik.org>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, gregkh@suse.de
Subject: Re: [git patch] improve INTx toggle for PCI MSI
In-Reply-To: <20061207225812.GA13917@havoc.gtf.org>
Message-ID: <Pine.LNX.4.64.0612081143220.20138@iabervon.org>
References: <20061207225812.GA13917@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2006, Jeff Garzik wrote:

> "it boots" on ICH7 at least.

It solves my problem (and doesn't break anything).

	-Daniel
*This .sig left intentionally blank*
