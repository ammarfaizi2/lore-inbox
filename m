Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262065AbUL1FB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262065AbUL1FB1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 00:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbUL1FB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 00:01:27 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:14249
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262065AbUL1FBY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 00:01:24 -0500
Date: Mon, 27 Dec 2004 21:00:07 -0800
From: "David S. Miller" <davem@davemloft.net>
To: yoshfuji@linux-ipv6.org
Cc: roland@topspin.com, linux-kernel@vger.kernel.org,
       openib-general@openib.org, akpm@osdl.org, torvalds@osdl.org,
       netdev@oss.sgi.com, yoshfuji@linux-ipv6.org
Subject: Re: [PATCH][v4][0/24] Second InfiniBand merge candidate patch set
Message-Id: <20041227210007.398734cd.davem@davemloft.net>
In-Reply-To: <20041220.153845.70996857.yoshfuji@linux-ipv6.org>
References: <200412192214.KlDxQ7icOmxHYIf0@topspin.com>
	<20041220.153845.70996857.yoshfuji@linux-ipv6.org>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2004 15:38:45 +0900 (JST)
YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org> wrote:

> In article <200412192214.KlDxQ7icOmxHYIf0@topspin.com> (at Sun, 19 Dec 2004 22:14:43 -0800), Roland Dreier <roland@topspin.com> says:
> 
> > The following series of patches is the latest version of the OpenIB
> > InfiniBand drivers.  We believe that this version is suitable for
> > merging when 2.6.11 opens (or into -mm immediately), although of
> > course we are willing to go through as many more iterations as
> > required to fix any remaining issues.
> 
> Maybe, via the net queue. David?

If Roland can resubmit his patch queue to me with the fixes
folks have recommended to him, I can start merging this stuff
in.

I leave for vacation Wednesday morning (PST time), so if it is
submitted after that I'll get to it at the beginning of the
new year.
