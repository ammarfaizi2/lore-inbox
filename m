Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266193AbUJHX2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266193AbUJHX2t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 19:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266195AbUJHX2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 19:28:49 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:10547 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S266193AbUJHX1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 19:27:16 -0400
To: Greg KH <greg@kroah.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
X-Message-Flag: Warning: May contain useful information
References: <20041008202247.GA9653@kroah.com>
From: Roland Dreier <roland@topspin.com>
Date: Fri, 08 Oct 2004 16:27:14 -0700
In-Reply-To: <20041008202247.GA9653@kroah.com> (Greg KH's message of "Fri, 8
 Oct 2004 13:22:47 -0700")
Message-ID: <528yagn63x.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [openib-general] InfiniBand incompatible with the Linux kernel?
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 08 Oct 2004 23:27:15.0214 (UTC) FILETIME=[5854F2E0:01C4AD8E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The increase in cost for the spec is rather unfortunate but I think
it's orthogonal to any IP issues.  Since the Linux kernel contains a
lot of code written to specs available only under NDA (and even
reverse-engineered code where specs are completely unavailable), I
don't think the expense should be an issue.

As for IP, as far as I know, there has been no change to any of the
bylaws or other members agreements.  If there is some specific
provision that concerns you, please bring it to our attention -- the
IBTA in general and the IBTA steering committee in general have been
very supportive of the OpenIB effort.  In fact, most of the IBTA
steering commitee companies (Agilent, HP, IBM, InfiniCon, Intel,
Mellanox, Sun, Topspin, and Voltaire) have been active participants in
OpenIB development.  I would hope we can resolve any issues relating
to open source and the Linux kernel.

However, I would suspect that we'll find the USB, Firewire, Bluetooth,
etc., etc. standards bodies all have very similar IP language in their
bylaws and licenses.

Thanks,
  Roland

