Return-Path: <linux-kernel-owner+w=401wt.eu-S936655AbWLKPgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936655AbWLKPgb (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 10:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936649AbWLKPgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 10:36:31 -0500
Received: from rrcs-24-153-217-226.sw.biz.rr.com ([24.153.217.226]:32840 "EHLO
	smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933568AbWLKPga (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 10:36:30 -0500
Subject: Re: [PATCH  v3 00/13] 2.6.20 Chelsio T3 RDMA Driver
From: Steve Wise <swise@opengridcomputing.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: netdev@vger.kernel.org, openib-general@openib.org,
       linux-kernel@vger.kernel.org, Divy Le Ray <divy@chelsio.com>,
       Felix Marti <felix@chelsio.com>
In-Reply-To: <adafybn2i7n.fsf@cisco.com>
References: <20061210223244.27166.36192.stgit@dell3.ogc.int>
	 <adafybn2i7n.fsf@cisco.com>
Content-Type: text/plain
Date: Mon, 11 Dec 2006 09:36:29 -0600
Message-Id: <1165851389.13419.3.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-12-10 at 20:02 -0800, Roland Dreier wrote:
> I haven't seen any evidence of the corresponding ethernet NIC driver
> being merged for 2.6.20 (which is a prerequisite, right).
> 
> What's the status of that?
> 

It is on its third or fourth round of review.  The last driver posted on
12/7, was merged up to linus's latest tree probably as of 12/7.  I know
the comments set it was against 2.6.19, but it was really linus's
latest.

Divy, can you expand on this?


Steve.

