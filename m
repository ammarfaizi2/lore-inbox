Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263698AbTLORzd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 12:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263805AbTLORzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 12:55:33 -0500
Received: from user-12hcje4.cable.mindspring.com ([69.22.77.196]:9096 "EHLO
	bender.davehollis.com") by vger.kernel.org with ESMTP
	id S263698AbTLORzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 12:55:32 -0500
Subject: Re: 'bad: scheduling while atomic!', preempt kernel, 2.6.1-test11,
	reading an apparently duff DVD-R
From: David T Hollis <dhollis@davehollis.com>
To: Toad <toad@amphibian.dyndns.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031215174908.GA29901@amphibian.dyndns.org>
References: <20031215135802.GA4332@amphibian.dyndns.org>
	 <Pine.LNX.4.58.0312150715410.1488@home.osdl.org> <3FDDD923.30509@pobox.com>
	 <20031215174908.GA29901@amphibian.dyndns.org>
Content-Type: text/plain
Message-Id: <1071510892.5272.18.camel@dhollis-lnx.kpmg.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Mon, 15 Dec 2003 12:54:56 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-12-15 at 12:49, Toad wrote:

> I've been completely unable to get cdrtools to compile... The version in
> debian is 2.0a19, which works with IDE-SCSI, and doesn't work without
> it. The RPM from the oss-dvd extension site doesn't work either without
> IDE-SCSI. Nor does dvd+rwtools. Anyone attempting to write DVDs will
> have real problems if IDE-SCSI is removed, judging by this experience.

I've been running 2.5/2.6 kernels since June and I've been able to use
cdrecord (2.x) from RedHat Rawhide/Fedora Core to burn CDs and DVDs
without ide-scsi the entire time.  I currently have
cdrecord-2.01-0.a19.3 installed (probably from Fedora devel) and it
works like a champ.

So long ide-scsi!

