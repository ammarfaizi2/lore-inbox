Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbUAISIu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 13:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbUAISIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 13:08:50 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:693 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S262714AbUAISIs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 13:08:48 -0500
Date: Fri, 9 Jan 2004 10:08:39 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Jakub Jelinek <jakub@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] invalid ELF binaries can execute - better sanity checking
Message-ID: <20040109180839.GW1882@matchmail.com>
Mail-Followup-To: Jesper Juhl <juhl-lkml@dif.dk>,
	Jakub Jelinek <jakub@redhat.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.56.0401090236390.11276@jju_lnx.backbone.dif.dk> <20040109102851.GF24876@devserv.devel.redhat.com> <Pine.LNX.4.56.0401091141200.12106@jju_lnx.backbone.dif.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0401091141200.12106@jju_lnx.backbone.dif.dk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 09, 2004 at 11:50:53AM +0100, Jesper Juhl wrote:
> I just wanted to get some feedback initially. The patch was a very minor
> bit of the email I send, and probably the least important bit.
> I wanted to get peoples reactions to the thought of adding stronger sanity
> checks. The patch was just a minor thing - the discussion about "do we
> want additional checks?" was the important bit.

There are some patches for the elf loader from one of the big names in LKML,
but I forgot who it was.  Maybe a search through google will bring something
up...
