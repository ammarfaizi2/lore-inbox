Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937051AbWLDTnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937051AbWLDTnw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 14:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937166AbWLDTnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 14:43:52 -0500
Received: from stargate.chelsio.com ([12.22.49.110]:14242 "EHLO
	stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937051AbWLDTnv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 14:43:51 -0500
Message-ID: <45747A6B.7010301@chelsio.com>
Date: Mon, 04 Dec 2006 11:43:39 -0800
From: Divy Le Ray <divy@chelsio.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH 0/10] cxgb3: Chelsio T3 1G/10G ethernet device driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Dec 2006 19:43:42.0086 (UTC) FILETIME=[80954A60:01C717DC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I resubmit the patch supporting the latest Chelsio T3 adapter.
It incoporpates feedbacks from Stephen and Jan.

This patch adds support for the latest Chelsio adapter, T3. It is built
against 2.6.19.

A corresponding monolithic patch against 2.6.19 is posted at the
following URL: http://service.chelsio.com/kernel.org/cxgb3.patch.bz2

We wish this patch to be considered for inclusion in 2.6.20. This driver
is required by the Chelsio T3 RDMA driver which was updated on 12/02/2006.

Cheers,
Divy

