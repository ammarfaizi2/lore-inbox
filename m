Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbTENQ2Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 12:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbTENQ2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 12:28:25 -0400
Received: from host132.googgun.cust.cyberus.ca ([209.195.125.132]:31164 "EHLO
	marauder.googgun.com") by vger.kernel.org with ESMTP
	id S262569AbTENQ2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 12:28:22 -0400
Date: Wed, 14 May 2003 12:38:54 -0400 (EDT)
From: Ahmed Masud <masud@googgun.com>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Yoav Weiss <ml-lkml@unpatched.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: encrypted swap [was: The disappearing sys_call_table export.]
In-Reply-To: <20030514162323.GB16093@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.33.0305141236430.12212-100000@marauder.googgun.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 14 May 2003, [iso-8859-1] Jörn Engel wrote:

> On Wed, 14 May 2003 12:13:03 -0400, Ahmed Masud wrote:
> >
> > The idea is to have encryption keys for the pages to be unique on a
> > per-uid per-process basis. So one user on the system cannot access (even
> > if they are root) parts of another's private data.  To achieve this,
> > different parts of swap device need to be encrypted with different keys.
>
> How do user *know* that root cannot simply bypass this security?
>
> Root, god, what's the difference? ;-)
>
> Jörn

Well :-) that's sorta true. In the new world the old gods will fall to
give rise to new ones.  worshippers of root will fade in the echos of the
past ... Rootshunting is possible if the kernel so chooses. Trusted Linux,
which is my perosnal and favourite focus for linux would be an environment
without root.


Ahmed.

