Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265749AbTIKBgB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 21:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265891AbTIKBgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 21:36:01 -0400
Received: from mail.webmaster.com ([216.152.64.131]:56791 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S265749AbTIKBf6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 21:35:58 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Pascal Schmidt" <der.eremit@email.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: People, not GPL  [was: Re: Driver Model]
Date: Wed, 10 Sep 2003 18:35:53 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKAEIKGHAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.44.0309110032240.3486-100000@neptune.local>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Wed, 10 Sep 2003, David Schwartz wrote:

> > Please show me one restriction on *use* in the GPL.

> Well, you may not *use* GPL'd code to produce a derived work and
> distribute it in binary form only.

	That is a restriction on distribution, not use. You may use GPL'd code to
produce a derived work and you may use that derived work. The only
restrictions kick in when and if you distribute that derived work.

> Use of the code, not use of
> the product, sure.

	The GPL puts no restrictions on use. The GPL_ONLY stuff does.

	It's really this simple: The GPL says you can use the code for whatever you
want. It also says that if you want to distribute the GPL'd work or works
based on the GPL'd work, you may not impose any restrictions other than
those imposed by the GPL. It very specifically prohibits restrictions on
mere use or upon the mere creation of derived works. All of its restrictions
kick in on distribution.

	The GPL_ONLY stuff is an attempt to restrict use. There is nothing
inherently wrong with attempts to restrict use. One could argue that the
root permission check on 'umount' is a restriction on use. Surely the GPL
doesn't mean you can't have any usage restrictions at all.

	What it does mean is that such usage restrictions *cannot* be licensing
restrictions. In other words, it cannot be a license violation to remove
them or circumvent them. So long as nobody tries to claim the GPL_ONLY is a
license enforcement technique, there is no dispute.

	However, some people seem to be arguing that the GPL_ONLY symbols are in
fact a license enforcement technique. If that's true, then when they
distribute their code, they are putting additional restrictions not in the
GPL on it. That is a GPL violation.

	Other people who contributed to the Linux kernel relied upon the GPL
license to ensure that their code, and works derived from it, would be
available *without* use restrictions. Nobody has the right to turn around
and impose usage restrictions on the Linux kernel source code.

	The GPL prohibits the imposition of any licensing requirements other than
those contained in the GPL itself, all of which kick in only upon
distribution. It's really that simple. Anyone who distributes the Linux
kernel with a licensing restriction that kicks in on mere use is violating
the GPL.

	DS


