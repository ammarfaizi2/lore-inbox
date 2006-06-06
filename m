Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbWFFO6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbWFFO6l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 10:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbWFFO6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 10:58:41 -0400
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:1724 "EHLO
	caffeine.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S932200AbWFFO6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 10:58:40 -0400
Date: Tue, 6 Jun 2006 10:58:39 -0400
To: Heiko Gerstung <heiko.gerstung@meinberg.de>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Backport of a 2.6.x USB driver to 2.4.32 - help needed
Message-ID: <20060606145839.GE7857@csclub.uwaterloo.ca>
References: <44854F74.50406@meinberg.de> <9a8748490606060423t102384f4m626b4366898ce9cd@mail.gmail.com> <448569CE.1020906@meinberg.de> <20060606144334.GA7859@csclub.uwaterloo.ca> <448595CC.8040607@meinberg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448595CC.8040607@meinberg.de>
User-Agent: Mutt/1.5.9i
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lsorense@csclub.uwaterloo.ca
X-SA-Exim-Scanned: No (on caffeine.csclub.uwaterloo.ca); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2006 at 04:48:44PM +0200, Heiko Gerstung wrote:
> It works but on my system it takes ~4 hours before I reach lower
> microsecond offsets, where the 2.4 ppskit is below 10 microseconds after
> four polling cycles. I already tried to fix that but the internal kernel
> pps discipline is not working as good as  it did with the 2.4 ppskit
> versions.

I guess that is the light part. :)

Len Sorensen
