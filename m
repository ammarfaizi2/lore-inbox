Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261585AbVACTqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbVACTqb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 14:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbVACTqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 14:46:31 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:31918 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261585AbVACTq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 14:46:29 -0500
To: Adrian Bunk <bunk@stusta.de>
Cc: mshefty@ichips.intel.com, halr@voltaire.com, openib-general@openib.org,
       linux-kernel@vger.kernel.org
X-Message-Flag: Warning: May contain useful information
References: <20050103172202.GH2980@stusta.de>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 03 Jan 2005 11:46:28 -0800
In-Reply-To: <20050103172202.GH2980@stusta.de> (Adrian Bunk's message of
 "Mon, 3 Jan 2005 18:22:02 +0100")
Message-ID: <52oeg670tn.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: infiniband: rename two source files?
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 03 Jan 2005 19:46:28.0631 (UTC) FILETIME=[EAB10A70:01C4F1CC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Adrian> Is it planned to add other objects to ib_sa and/or
    Adrian> ib_umad, or would you accept a patch to rename the source
    Adrian> files?

I think both modules are very close to the point where it would make
sense to split into multiple files, so I would prefer to leave things
as they are for now.

Thanks,
  Roland
