Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263183AbTE0KFz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 06:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbTE0KFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 06:05:55 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:33729 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S263183AbTE0KFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 06:05:54 -0400
To: Andrew Morton <akpm@digeo.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][v850]  Define flush_page_to_ram on v850/nb85e
References: <20030527092133.2B7A0375B@mcspd15.ucom.lsi.nec.co.jp>
	<20030527031514.34be520d.akpm@digeo.com>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 27 May 2003 19:18:42 +0900
In-Reply-To: <20030527031514.34be520d.akpm@digeo.com>
Message-ID: <buou1bgd75p.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> writes:
> flush_page_to_ram() has been removed from the kernel, so we no longer
> need this patch.

Yeah, I noticed that, 30 seconds _after_ the patches got sent, of
course ... :-/

-Miles
-- 
We live, as we dream -- alone....
