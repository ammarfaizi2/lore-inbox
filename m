Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262768AbUDUI5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262768AbUDUI5m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 04:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264320AbUDUI5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 04:57:42 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:53978 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S262768AbUDUI5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 04:57:40 -0400
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Jan De Luyck <lkml@kcore.org>, linux-kernel@vger.kernel.org,
       postmaster@vger.kernel.org
Subject: Re: vger.kernel.org is listed by spamcop
References: <200404210722.32253.lkml@kcore.org>
	<20040421084434.GL1749@mea-ext.zmailer.org>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 21 Apr 2004 17:56:41 +0900
In-Reply-To: <20040421084434.GL1749@mea-ext.zmailer.org>
Message-ID: <buoad15hfp2.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matti Aarnio <matti.aarnio@zmailer.org> writes:
> The only way to handle this is to have smarter people, who are always
> vigilant enough to look deeply into the message headers and do realize
> that some spam has leaked thru VGER's lists.

I'm confused -- the spamcopy info page you listed implies that hosts are
listed if they are an _open relay_, which is a completely different
thing from `spam leaking though VGER's lists.'

If VGER actually is an open relay, that's very bad, but presumably
something easily solved by the machine's maintainers.  Some spam getting
through to VGER list recipients, on the other hand, is just annoying
(and certainly shouldn't be the cause of any blacklisting).

The spamcop report page seems to say that the listings are due to user
reports; could the real problem be clueless users who don't understand
the difference above?

Does anyone have a better idea of what's actually going on?

Thanks,

-Miles
-- 
Fast, small, soon; pick any 2.
