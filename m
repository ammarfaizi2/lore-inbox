Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161135AbWBQAQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161135AbWBQAQu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 19:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161133AbWBQAQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 19:16:49 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:58628 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1161137AbWBQAQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 19:16:49 -0500
To: Greg KH <greg@kroah.com>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Roland Dreier <rolandd@cisco.com>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: AMD 8131 and MSI quirk
X-Message-Flag: Warning: May contain useful information
References: <524q799p2t.fsf@cisco.com> <20060214165222.GC12974@mellanox.co.il>
	<20060217000927.GA22149@kroah.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 16 Feb 2006 16:16:46 -0800
In-Reply-To: <20060217000927.GA22149@kroah.com> (Greg KH's message of "Thu,
 16 Feb 2006 16:09:27 -0800")
Message-ID: <adaek22hma9.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 17 Feb 2006 00:16:46.0377 (UTC) FILETIME=[702C7190:01C63357]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Greg> Roland, did you ever verify that this patch worked or not for you?

Unfortunately as I said I don't have such a system (with AMD 8131 and
also a host bus controller that _does_ support MSI) myself.

Michael has tested on systems with AMD 8131, so I don't think the
patch could hurt.

 - R.
