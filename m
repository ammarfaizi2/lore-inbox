Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbVBOWyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbVBOWyg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 17:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbVBOWxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 17:53:44 -0500
Received: from fire.osdl.org ([65.172.181.4]:49611 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261925AbVBOWwW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 17:52:22 -0500
Date: Tue, 15 Feb 2005 14:52:20 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Peter Hagervall <hager@cs.umu.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kill some sparse warnings
In-Reply-To: <20050215224553.GA24630@peppar.cs.umu.se>
Message-ID: <Pine.LNX.4.58.0502151451480.2330@ppc970.osdl.org>
References: <20050215224553.GA24630@peppar.cs.umu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 Feb 2005, Peter Hagervall wrote:
>
> Cleaned up some address space issues in:

I'm holding off these for now, but you might check with Al Viro, since 
he's got a ton in store for a post-2.6.11 merge.

		Linus
