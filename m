Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130519AbQLEVlr>; Tue, 5 Dec 2000 16:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130551AbQLEVlh>; Tue, 5 Dec 2000 16:41:37 -0500
Received: from 194-73-188-168.btconnect.com ([194.73.188.168]:37384 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S130519AbQLEVlc>;
	Tue, 5 Dec 2000 16:41:32 -0500
Date: Tue, 5 Dec 2000 21:13:05 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: "Dunlap, Randy" <randy.dunlap@intel.com>
cc: linux-kernel@vger.kernel.org
Subject: RE: [bug] vfsmount->count accounting broken again?
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDDE5@orsmsx31.jf.intel.com>
Message-ID: <Pine.LNX.4.21.0012052112270.1683-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2000, Dunlap, Randy wrote:

> Andries wrote Monday 4-dec-2000 about a umount patch
> for this:

Randy, presumably you mean the userspace side, yes? I.e. not the kernel
bug I reported. I should have put a subject [two bugs] instead of [bug].

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
