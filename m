Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbWCJAA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbWCJAA3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 19:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWCJAA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 19:00:29 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:50332 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S932187AbWCJAA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 19:00:28 -0500
X-IronPort-AV: i="4.02,180,1139212800"; 
   d="scan'208"; a="260913654:sNHT30815954"
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 9 of 20] ipath - char devices for diagnostics and lightweight subnet management
X-Message-Flag: Warning: May contain useful information
References: <eac2ad3017b5f160d24c.1141922822@localhost.localdomain>
	<ada8xrjfbd8.fsf@cisco.com>
	<1141948367.10693.53.camel@serpentine.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 09 Mar 2006 16:00:25 -0800
In-Reply-To: <1141948367.10693.53.camel@serpentine.pathscale.com> (Bryan O'Sullivan's message of "Thu, 09 Mar 2006 15:52:47 -0800")
Message-ID: <ada64mndv8m.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 10 Mar 2006 00:00:26.0431 (UTC) FILETIME=[A2C14CF0:01C643D5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Bryan> We don't support hotplugged devices at the moment.  If
    Bryan> you're asking whether an rmmod at the wrong time could
    Bryan> cause something bad to happen, I don't *think* so.

How do you stop someone from hot plugging a PCIe device?

 - R.
