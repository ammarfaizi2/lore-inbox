Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265686AbUBPQZv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 11:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265692AbUBPQZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 11:25:51 -0500
Received: from [212.28.208.94] ([212.28.208.94]:44805 "HELO dewire.com")
	by vger.kernel.org with SMTP id S265686AbUBPQZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 11:25:50 -0500
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: John Bradford <john@grabjohn.com>
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Date: Mon, 16 Feb 2004 17:25:46 +0100
User-Agent: KMail/1.6.1
Cc: Valdis.Kletnieks@vt.edu, Eduard Bloch <edi@gmx.de>,
       Jamie Lokier <jamie@shareable.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
References: <20040209115852.GB877@schottelius.org> <200402161518.i1GFIpn2008826@turing-police.cc.vt.edu> <200402161546.i1GFkLqx000741@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200402161546.i1GFkLqx000741@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402161725.46593.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 February 2004 16.46, John Bradford wrote:
> Maybe we should forget filename encoding altogether, and start
> thinking of filenames as arbitrary sequences of _32-bit words_.
> Existing applications can store their arbitrary byte sequences in the
> low byte, and new calls can be added to provide Unicode-aware
> userspace applications with access to the 32-bit space, which _must_
> be used for UCS-4.

You forgot a :-). Right :-/

-- robin
