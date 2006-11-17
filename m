Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755867AbWKQUZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755867AbWKQUZR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 15:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755866AbWKQUZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 15:25:16 -0500
Received: from stargate.chelsio.com ([12.22.49.110]:49744 "EHLO
	stargate.chelsio.com") by vger.kernel.org with ESMTP
	id S1755864AbWKQUZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 15:25:13 -0500
Message-ID: <455E19FC.7060505@chelsio.com>
Date: Fri, 17 Nov 2006 12:22:20 -0800
From: Divy Le Ray <divy@chelsio.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/10] cxgb3: Chelsio T3 1G/10G ethernet device driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Nov 2006 20:22:23.0416 (UTC) FILETIME=[172E6380:01C70A86]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Based on Arnd's feedback, I re-submit the patch supporting the latest
Chelsio T3 adapter in inlined mails.  Some header files were trimmed
down to reduce the code footprint.

This patch adds support for the latest Chelsio adapter, T3.  It is built
against 2.6.19-rc6.

A corresponding monolithic patch against 2.6.19-rc6 is posted at the
following URL: http://service.chelsio.com/kernel.org/cxgb3.patch.bz2

We wish this patch to be considered for inclusion in 2.6.20. This driver
is required by the Chelsio T3 RDMA driver which was posted on 11/15/2006.

Cheers,
Divy

