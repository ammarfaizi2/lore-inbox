Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264543AbTFIREX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 13:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264544AbTFIREX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 13:04:23 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:55168 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264543AbTFIREU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 13:04:20 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 9 Jun 2003 10:15:51 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Coding standards.  (Was: Re: [PATCH] [2.5] Non-blocking write
 can block)
In-Reply-To: <20030609163959.GA13811@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.55.0306091001270.3614@bigblue.dev.mcafeelabs.com>
References: <Pine.HPX.4.33L.0306040144400.8930-100000@punch.eng.cam.ac.uk>
 <20030604065336.A7755@infradead.org> <3EDE0E85.7090601@techsource.com>
 <20030607001202.GB14475@kroah.com> <3EE4B4C3.80902@techsource.com>
 <20030609163959.GA13811@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jun 2003, [iso-8859-1] Jörn Engel wrote:

> In the case of the kernel, there is quite a bit of horrible coding
> style.  But a working device driver for some hardware is always better
> that no working device driver for some hardware, and if enforcing the
> coding style more results is scaring away some driver writers, the
> style clearly loses.

There's no such a thing as "horrible coding style", since coding style is
strictly personal. Whoever try to convince you that one style is better
than another one is simply plain wrong. Every reason they will give you to
justify one style can be wiped with other opposite reasons. The only
horrible coding style is to not respect coding standards when you work
inside a project. This is a form of respect for other people working
inside the project itself, give the project code a more professional
look and lower the fatigue of reading the project code. Jumping from 24
different coding styles does not usually help this. I do not believe
professional developers can be scared by a coding style, if this is the
coding style adopted by the project where they have to work in.



- Davide

