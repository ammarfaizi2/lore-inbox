Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264256AbUFXLG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbUFXLG7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 07:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264262AbUFXLG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 07:06:59 -0400
Received: from chaos.analogic.com ([204.178.40.224]:14983 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264256AbUFXLG5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 07:06:57 -0400
Date: Thu, 24 Jun 2004 07:06:45 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Pete Zaitcev <zaitcev@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Alphabet of kernel source
In-Reply-To: <20040623140628.3f1abfe9@lembas.zaitcev.lan>
Message-ID: <Pine.LNX.4.53.0406240700480.23948@chaos>
References: <20040623140628.3f1abfe9@lembas.zaitcev.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jun 2004, Pete Zaitcev wrote:

> Guys,
>
> I have a silly question, for which I am unable to google out the answer
> so far. Do we have a Linus' decree on the charset and encoding of the
> kernel source?
>
[SNIPPED...]

Good question!  It was supposed to be ASCII which, I guess is
UTF-8 or something like that. However, I find that tabs, which
were decreed to be at 8-collumn intervals end up being used
instead of spaces i.e., one-column, etc. So, if you look at
some well-patched source you sometimes see a mess.

The names of contributors often have non-ASCII characters
in them. This may not be a problem, but when using `pine`
without the 'latest-and-greatest' version, they sometimes
are unreadable.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


