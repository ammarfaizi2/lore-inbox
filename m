Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263111AbTD1B0n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 21:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263118AbTD1B0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 21:26:43 -0400
Received: from c-51a870d5.037-69-73746f23.cust.bredbandsbolaget.se ([213.112.168.81]:50358
	"EHLO zaphod.guide") by vger.kernel.org with ESMTP id S263111AbTD1B0m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 21:26:42 -0400
To: Mark Grosberg <mark@nolab.conman.org>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFD] Combined fork-exec syscall.
References: <Pine.BSO.4.44.0304272114560.23296-100000@kwalitee.nolab.conman.org>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 28 Apr 2003 03:36:17 +0200
In-Reply-To: <Pine.BSO.4.44.0304272114560.23296-100000@kwalitee.nolab.conman.org>
Message-ID: <yw1xptn7z9m6.fsf@zaphod.guide>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Portable Code)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Grosberg <mark@nolab.conman.org> writes:

> > If you do this, _please_ make it compat with NT.
> 
> Actually, I thought about this. My first thought is this could benefit
> WINE running on Linux. Then (not like I'm a Wine expert by any means) I
> figured it might be an issue as far as having to do some preliminary
> wineserver setup work (if anybody on this list knows better than me, speak
> up!)
> 
> But yeah, basically, something similar to NT's CreateProcess(). For the
> cases where the one-step process creation is sufficient.

Is that the call that takes dozens of parameters?  Copying :-) that
is, IMHO, straight against the UNIX philosophy.

-- 
Måns Rullgård
mru@users.sf.net
