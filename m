Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751900AbWI1Nu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900AbWI1Nu4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 09:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbWI1Nu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 09:50:56 -0400
Received: from 2-1-3-15a.ens.sth.bostream.se ([82.182.31.214]:18837 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id S1751900AbWI1Nuz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 09:50:55 -0400
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Sergey Panov <sipan@sipan.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com>
	<1159319508.16507.15.camel@sipan.sipan.org>
	<Pine.LNX.4.61.0609270753590.19275@yvahk01.tjqt.qr>
	<1159342569.2653.30.camel@sipan.sipan.org>
	<Pine.LNX.4.61.0609271051550.19438@yvahk01.tjqt.qr>
	<1159359540.11049.347.camel@localhost.localdomain>
	<Pine.LNX.4.64.0609271000510.3952@g5.osdl.org>
	<Pine.LNX.4.61.0609280947360.21498@yvahk01.tjqt.qr>
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 28 Sep 2006 15:50:54 +0200
In-Reply-To: <Pine.LNX.4.61.0609280947360.21498@yvahk01.tjqt.qr>
Message-ID: <m3mz8k3xs1.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> writes:

> Hah then read LICENSE.LGPL!
> 
> """Most GNU software, including some libraries, is covered by the
> ordinary GNU General Public License.  This license, the GNU Lesser
> General Public License, applies to certain designated libraries, and
> is quite different from the ordinary General Public License.  We use
> this license for certain libraries in order to permit linking those
> libraries into non-free programs."""
> 
> If the GPL does not mention linking at all, and therefore does not
> really forbid it, why do we need an LGPL to allow linking then?

Clarification, just as the system call clarification in the Linux
kernel COPYING file.  By explicitly allowing dynamic linking the LGPL
makes it clear that it is ok and avoids a lot of legal uncertainty.
It may be that the that linking doesn't legally create a derived work,
and that a bunch of the claims in the GPL are invalid, but to find out
somebody has to bring it to court, get a judgement (not a settlement),
and appeal it all the way to the supreme court.  And to be really sure
they'd have to do it in just about every country too.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
