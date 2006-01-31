Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030349AbWAaGtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030349AbWAaGtN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 01:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030351AbWAaGtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 01:49:13 -0500
Received: from smtp106.sbc.mail.mud.yahoo.com ([68.142.198.205]:29799 "HELO
	smtp106.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030347AbWAaGtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 01:49:13 -0500
Date: Mon, 30 Jan 2006 22:49:07 -0800
From: Chris Wedgwood <cw@f00f.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Neil Brown <neilb@suse.de>, linux-raid@vger.kernel.org,
       klibc list <klibc@zytor.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [klibc] Re: Exporting which partitions to md-configure
Message-ID: <20060131064907.GA10934@taniwha.stupidest.org>
References: <43DEB4B8.5040607@zytor.com> <17374.47368.715991.422607@cse.unsw.edu.au> <43DEC095.2090507@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DEC095.2090507@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2006 at 05:42:45PM -0800, H. Peter Anvin wrote:

> What about non-DOS partitions?

Is something like libblkid suitable as a starting point of something
you can cut-down-to-size?

   text    data     bss     dec     hex filename
  24978    2272      12   27262    6a7e /lib/libblkid.so.1
