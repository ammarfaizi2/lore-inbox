Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263617AbTJZUGr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 15:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263645AbTJZUGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 15:06:47 -0500
Received: from imap.gmx.net ([213.165.64.20]:53645 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263275AbTJZUGp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 15:06:45 -0500
X-Authenticated: #20450766
Date: Sun, 26 Oct 2003 20:49:01 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: linux-kernel@vger.kernel.org
cc: Kurt Garloff <garloff@suse.de>, <linux-scsi@vger.kernel.org>
Subject: Re: AMD 53c974 SCSI driver in 2.6
In-Reply-To: <Pine.LNX.4.44.0310252340090.11248-100000@poirot.grange>
Message-ID: <Pine.LNX.4.44.0310262035270.3346-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Oct 2003, Guennadi Liakhovetski wrote:

> The above (AM53C974) driver depends on BROKEN in 2.6 and doesn't compile.
> Is anybody working on / planning to fix it?

In a private email Matthias Andree suggested to try the tmscsim driver,
which is [retty badly broken too. So, the question: what is the future of
these drivers? Are they slowly dying because the hardware is outdated, or
are they going to be fixed? If the latter - what is the status of this
work (if any), and - which of the 2 (or both) drivers should survive?

Thanks
Guennadi
---
Guennadi Liakhovetski


