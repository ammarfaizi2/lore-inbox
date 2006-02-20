Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161017AbWBTQxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161017AbWBTQxE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 11:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161028AbWBTQxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 11:53:04 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:61212 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1161017AbWBTQxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 11:53:02 -0500
To: Anton Blanchard <anton@samba.org>
Cc: Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, openib-general@openib.org,
       SCHICKHJ@de.ibm.com, RAISCH@de.ibm.com, HNGUYEN@de.ibm.com,
       MEDER@de.ibm.com
Subject: Re: [PATCH 21/22] ehca main file
X-Message-Flag: Warning: May contain useful information
References: <20060218005532.13620.79663.stgit@localhost.localdomain>
	<20060218005759.13620.10968.stgit@localhost.localdomain>
	<20060220152213.GD19895@krispykreme>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 20 Feb 2006 08:52:55 -0800
In-Reply-To: <20060220152213.GD19895@krispykreme> (Anton Blanchard's message
 of "Tue, 21 Feb 2006 02:22:13 +1100")
Message-ID: <adabqx27z14.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 20 Feb 2006 16:52:56.0939 (UTC) FILETIME=[1971ABB0:01C6363E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Anton> No need for kernel version ifdefs.

Sorry, I tried to strip these out before posting the patch, but I
missed one.

Anyway, totally agree on the ifdefs and I will be double-extra-sure
that the final version doesn't include them.

 - R.
