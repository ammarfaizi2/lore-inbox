Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262783AbSKZERt>; Mon, 25 Nov 2002 23:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262803AbSKZERt>; Mon, 25 Nov 2002 23:17:49 -0500
Received: from thunk.org ([140.239.227.29]:62409 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S262783AbSKZERs>;
	Mon, 25 Nov 2002 23:17:48 -0500
Date: Mon, 25 Nov 2002 23:24:56 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Dennis Grant <trog@wincom.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A Kernel Configuration Tale of Woe
Message-ID: <20021126042456.GC11903@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Dennis Grant <trog@wincom.net>, linux-kernel@vger.kernel.org
References: <3de26215.842.0@wincom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3de26215.842.0@wincom.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2002 at 12:33:18PM -0500, Dennis Grant wrote:
> For example, I want to be able to pick my motherboard model out of a
> list. I then want to be presented with a list of components that are
> options on that model on an ITEM basis (ie "gigabit ethernet
> controller" not "Broadcom FOOBAR73541") and then select the options
> that I have.

The major problem with this idea is the question: who will pay for
keeping this database of motherboard models, et. al, up to date?

If it is done purely on a voluntary basis, it will have huge gaps, and
then there will be people complaining about why the #!@$#@
configuration system doesn't list their motherboard.  Even Microsoft
hasn't attempted to do what you have described, and for good reason
--- new motherboards and new chipsets appear far too often for any
software product to be able to track this with any hope of success.

						- Ted
