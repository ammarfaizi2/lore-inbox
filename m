Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272230AbTHDUTl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 16:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272232AbTHDUTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 16:19:40 -0400
Received: from p68.rivermarket.wintek.com ([208.13.56.68]:4834 "EHLO dust")
	by vger.kernel.org with ESMTP id S272230AbTHDUSO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 16:18:14 -0400
Date: Mon, 4 Aug 2003 15:21:53 -0500 (EST)
From: Alex Goddard <agoddard@purdue.edu>
To: Alexander Hoogerhuis <alexh@ihatent.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-tst2-mm4 and ide-scsi
In-Reply-To: <871xw1kyu2.fsf@lapper.ihatent.com>
Message-ID: <Pine.LNX.4.56.0308041520540.3506@dust>
References: <871xw1kyu2.fsf@lapper.ihatent.com>
X-GPG-PUBLIC_KEY: N/a
X-GPG-FINGERPRINT: BCBC 0868 DB78 22F3 A657 785D 6E3B 7ACB 584E B835
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Aug 2003, Alexander Hoogerhuis wrote:

> Got this oops when burning a CD under mdoerate load on my laptop jsut
> now:

[Snip]

Tried burning without ide-scsi?  As long as you have a recent enough
version of cdrtools, ide-scsi is no longer necessary in 2.5/2.6.  I
haven't used ide-scsi in months, and CD burning works just fine.

-- 
Alex Goddard
agoddard@purdue.edu
