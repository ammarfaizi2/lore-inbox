Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129707AbQKGWxZ>; Tue, 7 Nov 2000 17:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130293AbQKGWwz>; Tue, 7 Nov 2000 17:52:55 -0500
Received: from kanga.kvack.org ([216.129.200.3]:25349 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id <S129598AbQKGWwu>;
	Tue, 7 Nov 2000 17:52:50 -0500
Date: Tue, 7 Nov 2000 17:51:26 -0500 (EST)
From: <kernel@kvack.org>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
cc: Martin Josefsson <gandalf@wlug.westbo.se>,
        Tigran Aivazian <tigran@veritas.com>, Anil kumar <anils_r@yahoo.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Installing kernel 2.4
In-Reply-To: <3A08830E.F714C90E@timpanogas.org>
Message-ID: <Pine.LNX.3.96.1001107175009.1482C-100000@kanga.kvack.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2000, Jeff V. Merkey wrote:

> So how come NetWare and NT can detect this at run time, and we have to
> use a .config option to specifiy it?  Come on guys.....

Then run a kernel compiled for i386 and suffer the poorer code quality
that comes with not using newer instructions and including the
workarounds for ancient hardware.

		-ben

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
