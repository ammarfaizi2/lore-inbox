Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263072AbVFXEEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263072AbVFXEEY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 00:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263098AbVFXEEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 00:04:24 -0400
Received: from webmail.topspin.com ([12.162.17.3]:33605 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S263072AbVFXEEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 00:04:21 -0400
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH 00/14] IB/mthca: merge
In-Reply-To: 
X-Mailer: Roland's Patchbomber
Date: Thu, 23 Jun 2005 21:04:20 -0700
Message-Id: <2005623214.eJuSN72mmScT1do9@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 24 Jun 2005 04:04:20.0386 (UTC) FILETIME=[CC486020:01C57871]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a series of patches to the mthca Mellanox HCA driver.  Some of
the patches are largish but there shouldn't be anything too major
here.  This is mostly to bring my tree closer to the main kernel and
make the merge of direct userspace access smaller, since it will
require plenty of review.

Thanks,
  Roland


