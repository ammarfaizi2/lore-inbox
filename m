Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262371AbUKQQhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262371AbUKQQhY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 11:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbUKQQfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 11:35:01 -0500
Received: from sanosuke.troilus.org ([66.92.173.88]:39643 "EHLO
	sanosuke.troilus.org") by vger.kernel.org with ESMTP
	id S262401AbUKQQdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 11:33:08 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Charles Cazabon <linux@discworld.dyndns.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: GPL version, "at your option"?
References: <1100614115.16127.16.camel@ghanima>
	<20041116144029.GA6740@discworld.dyndns.org>
	<1100704019.32698.24.camel@localhost.localdomain>
From: Michael Poole <mdpoole@troilus.org>
Date: 17 Nov 2004 11:33:04 -0500
In-Reply-To: <1100704019.32698.24.camel@localhost.localdomain>
Message-ID: <87y8h08mgv.fsf@sanosuke.troilus.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:

> The use of this by some kernel people is to issue "this version only"
> licenses is unfortunate, ill advised and potentially harmful. Firstly it
> isn't remotely clear what it means because the license itself never
> talks about this case, only the "or later" case. Secondly it may force
> code chunks to be rewritten if the GPL is modified to fix a legal
> problem in future and the original author or their estate or company [*]
> cannot be traced. Thirdly it may actually be meaningless anyway - the
> GPL doesn't talk about "this version only" in any of its text so it may
> be an "additional restriction" and thus a void clause.

I have no argument that restricting it to v2 is potentially harmful,
but allowing distribution under GPL v3 is also potentially harmful
since the terms are not yet known, and later v3plus changes would
restrict the whole work to v3plus.

As for the "additional restriction" theory, the FSF apparently does
not think it is a restriction; the GPL says what happens *if* the
program says "or any later version."  If the intent were to always
allow newer license, that should be clearly written into the license
rather than making it conditional.  The GPL FAQ[1] implies that "or
any later version" is optional.  When the issue came up on
debian-legal earlier this year, Dave Turner provided an answer[2].

Michael Poole

[1]- http://www.fsf.org/licenses/gpl-faq.html#VersionTwoOrLater
[2]- http://lists.debian.org/debian-legal/2004/08/msg00821.html
