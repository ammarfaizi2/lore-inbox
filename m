Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264526AbUHAF33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264526AbUHAF33 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 01:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264843AbUHAF33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 01:29:29 -0400
Received: from hierophant.serpentine.com ([66.92.13.71]:49365 "EHLO
	demesne.serpentine.com") by vger.kernel.org with ESMTP
	id S264526AbUHAF32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 01:29:28 -0400
Subject: Re: Recent 2.6 kernels can't read an entire ATAPI CD or DVD
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Jens Axboe <axboe@suse.de>
Cc: Robert Love <rml@ximian.com>, Arjan van de Ven <arjanv@redhat.com>,
       Dave Jones <davej@redhat.com>,
       Edward Angelo Dayao <edward.dayao@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040730055333.GC7925@suse.de>
References: <20040728053107.GB11690@suse.de>
	 <c93051e8040727235123a6ed67@mail.gmail.com>
	 <20040728065319.GD11690@suse.de> <20040728145228.GA9316@redhat.com>
	 <20040728145543.GB18846@devserv.devel.redhat.com>
	 <20040728163353.GJ10377@suse.de> <20040728170507.GK10377@suse.de>
	 <1091051858.13651.1.camel@camp4.serpentine.com>
	 <20040729084928.GR10377@suse.de> <1091166553.1982.9.camel@localhost>
	 <20040730055333.GC7925@suse.de>
Content-Type: text/plain
Date: Sat, 31 Jul 2004 22:29:27 -0700
Message-Id: <1091338167.9028.12.camel@camp4.serpentine.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 (1.5.9.1-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-30 at 07:53 +0200, Jens Axboe wrote:

> read-ahead doesn't matter on ripping audio, just for fs work.

When I tried using dd with readahead off, I got the same error almost
immediately, instead of after a number of seconds.  In other words, it
made the problem worse.

	<b

