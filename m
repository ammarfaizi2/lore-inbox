Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264404AbUEMTBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264404AbUEMTBW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 15:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264406AbUEMTBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 15:01:22 -0400
Received: from ultra12.almamedia.fi ([193.209.83.38]:4524 "EHLO
	ultra12.almamedia.fi") by vger.kernel.org with ESMTP
	id S264404AbUEMTBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 15:01:21 -0400
Message-ID: <40A3C639.4FD98046@users.sourceforge.net>
Date: Thu, 13 May 2004 22:02:17 +0300
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1r6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: michal@logix.cz, jmorris@redhat.com, davem@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Support for VIA PadLock crypto engine
References: <Xine.LNX.4.44.0405120933010.10943-100000@thoron.boston.redhat.com>
			<Pine.LNX.4.53.0405121546200.24118@maxipes.logix.cz>
			<40A37118.ED58E781@users.sourceforge.net> <20040513113028.085194a3.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jari Ruusu <jariruusu@users.sourceforge.net> wrote:
> >  The cryptoloop implementation is busted in more than one way, so it is
> >  useless for security needs:
> 
> Is dm-crypt any better?

Nope. dm-crypt has same exploitable cryptographic flaws.

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
