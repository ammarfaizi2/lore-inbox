Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbULKNXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbULKNXg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 08:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbULKNXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 08:23:36 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:30050 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261385AbULKNXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 08:23:35 -0500
To: Greg KH <greg@kroah.com>
Cc: David Brownell <david-b@pacbell.net>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
X-Message-Flag: Warning: May contain useful information
References: <20041210005055.GA17822@kroah.com>
	<200412101729.01155.david-b@pacbell.net>
	<20041211013930.GB12846@kroah.com> <52is797eom.fsf@topspin.com>
	<20041211023243.GA18663@kroah.com>
From: Roland Dreier <roland@topspin.com>
Date: Sat, 11 Dec 2004 05:23:07 -0800
In-Reply-To: <20041211023243.GA18663@kroah.com> (Greg KH's message of "Fri,
 10 Dec 2004 18:32:43 -0800")
Message-ID: <52ekhx6kas.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [linux-usb-devel] [RFC PATCH] debugfs - yet another in-kernel
 file system
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 11 Dec 2004 13:23:08.0056 (UTC) FILETIME=[8DC79180:01C4DF84]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Greg> Oh yes, it would be optional.  I still like the simple
    Greg> interface that debugfs is providing so far, I'll just add
    Greg> yet-another-way-to-create-a-file type function that takes a
    Greg> kobject.

    Greg> Sound ok?

Yep, that works for me.

Thanks,
  Roland
