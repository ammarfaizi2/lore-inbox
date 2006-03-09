Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbWCIXwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWCIXwK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWCIXwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:52:09 -0500
Received: from test-iport-1.cisco.com ([171.71.176.117]:38423 "EHLO
	test-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932181AbWCIXwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:52:07 -0500
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 9 of 20] ipath - char devices for diagnostics and lightweight subnet management
X-Message-Flag: Warning: May contain useful information
References: <eac2ad3017b5f160d24c.1141922822@localhost.localdomain>
	<adalkvjfbo0.fsf@cisco.com>
	<1141947581.10693.45.camel@serpentine.pathscale.com>
	<adamzfzdvuo.fsf@cisco.com>
	<1141948253.10693.50.camel@serpentine.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 09 Mar 2006 15:52:06 -0800
In-Reply-To: <1141948253.10693.50.camel@serpentine.pathscale.com> (Bryan O'Sullivan's message of "Thu, 09 Mar 2006 15:50:53 -0800")
Message-ID: <adaacbzdvmh.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 09 Mar 2006 23:52:06.0681 (UTC) FILETIME=[78E18090:01C643D4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Roland> That's fine.  So then I guess the question is, why can't
    Roland> you use your SMA all the time?

    Bryan> We do.  It coexists with OpenSM if OpenSM is present.

So can we kill the other SMA?

 - R.
