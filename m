Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263972AbTDWHHe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 03:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263973AbTDWHHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 03:07:33 -0400
Received: from [12.47.58.232] ([12.47.58.232]:32069 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263972AbTDWHHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 03:07:33 -0400
Date: Wed, 23 Apr 2003 00:20:21 -0700
From: Andrew Morton <akpm@digeo.com>
To: "David S. Miller" <davem@redhat.com>
Cc: geert@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use __GFP_REPEAT in pmd_alloc_one()
Message-Id: <20030423002021.4a9481c7.akpm@digeo.com>
In-Reply-To: <1051081930.11999.2.camel@rth.ninka.net>
References: <Pine.GSO.4.21.0304221033150.15088-100000@vervain.sonytel.be>
	<1051081930.11999.2.camel@rth.ninka.net>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Apr 2003 07:19:34.0553 (UTC) FILETIME=[B0E4A890:01C30968]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> wrote:
>
> On Tue, 2003-04-22 at 02:46, Geert Uytterhoeven wrote:
> > If this change was bogus (cfr. Davem's checkin):
> ...
> > Then this one is bogus, too:
> 
> I don't think so, I believe Andrew was just trying to trap cases he
> didn't understand.

No, it was just a flip of the singers.  I typed `l' instead of control-l.
It was late.  Sorry 'bout that.


