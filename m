Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289376AbSBJJTC>; Sun, 10 Feb 2002 04:19:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289385AbSBJJSw>; Sun, 10 Feb 2002 04:18:52 -0500
Received: from [62.14.192.20] ([62.14.192.20]:16903 "EHLO pau.intranet.ct")
	by vger.kernel.org with ESMTP id <S289376AbSBJJSk>;
	Sun, 10 Feb 2002 04:18:40 -0500
Date: Sat, 9 Feb 2002 22:13:15 +0100 (CET)
From: Pau Aliagas <linuxnow@wanadoo.es>
X-X-Sender: pau@pau.intranet.ct
To: David Lang <david.lang@digitalinsight.com>
cc: Larry McVoy <lm@bitmover.com>, <linux-kernel@vger.kernel.org>
Subject: Re: pull vs push (was Re: [bk patch] Make cardbus compile in -pre4)
In-Reply-To: <Pine.LNX.4.44.0202091305510.25220-100000@dlang.diginsite.com>
Message-ID: <Pine.LNX.4.44.0202092211330.17916-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Feb 2002, David Lang wrote:

> I just set this up between a couple machines at work and one thing we
> ended up doing to get it to work was to generate a key without a
> passphrase on it to use for syncing, otherwise the ssh on the machine
> inititing the connection wanted a password to start the connection. you
> also need to do the stuff mentioned for the receiving end so that it
> doesn't ask for a password.

That's ok if you can't type the password as in batch jobs.

Pau

