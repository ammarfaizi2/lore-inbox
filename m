Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130343AbQKUWQM>; Tue, 21 Nov 2000 17:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130875AbQKUWQC>; Tue, 21 Nov 2000 17:16:02 -0500
Received: from 154.145.126.209.cari.net ([209.126.145.154]:41990 "EHLO
	newportharbornet.com") by vger.kernel.org with ESMTP
	id <S130343AbQKUWPv>; Tue, 21 Nov 2000 17:15:51 -0500
Date: Tue, 21 Nov 2000 13:46:10 -0800 (PST)
From: Bob Lorenzini <hwm@ns.newportharbornet.com>
To: David Riley <oscar@the-rileys.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Defective Red Hat Distribution poorly represents Linux
In-Reply-To: <3A1AE442.E8C83873@the-rileys.net>
Message-ID: <Pine.LNX.4.21.0011211341170.7745-100000@newportharbornet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2000, David Riley wrote:

> Horst von Brand wrote:
> 
> Windoze is not the only OS to handle bad hardware better than Linux.  On
> my Mac, I had a bad DIMM that worked fine on the MacOS side, but kept
> causing random bus-type errors in Linux.  Same as when I accidentally

I believe Linux uses memory from the top down rather than from the bottom
up like MS which may explain some of the reports that "it werks great in
windoze" where the faulty bit is high in the map.

Bob

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
