Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751632AbWCMR0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbWCMR0r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 12:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751550AbWCMR0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 12:26:47 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:13091 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S1751233AbWCMR0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 12:26:46 -0500
X-IronPort-AV: i="4.02,187,1139212800"; 
   d="scan'208"; a="313735804:sNHT29598686"
To: "Sean Hefty" <sean.hefty@intel.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <openib-general@openib.org>
Subject: Re: [PATCH 5/6 v2] IB: IP address based RDMA connection manager
X-Message-Flag: Warning: May contain useful information
References: <ORSMSX401FRaqbC8wSA0000001e@orsmsx401.amr.corp.intel.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 13 Mar 2006 09:26:43 -0800
In-Reply-To: <ORSMSX401FRaqbC8wSA0000001e@orsmsx401.amr.corp.intel.com> (Sean Hefty's message of "Mon, 13 Mar 2006 09:11:34 -0800")
Message-ID: <ada64mife7g.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 13 Mar 2006 17:26:45.0734 (UTC) FILETIME=[4D5FF860:01C646C3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Sean> It's dropping the reference on cma_dev, as opposed to
    Sean> id_priv.

Duh, sorry.

 - R.
