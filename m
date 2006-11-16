Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162095AbWKPAM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162095AbWKPAM4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 19:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162093AbWKPAM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 19:12:56 -0500
Received: from stargate.chelsio.com ([12.22.49.110]:56858 "EHLO
	stargate.chelsio.com") by vger.kernel.org with ESMTP
	id S1162092AbWKPAMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 19:12:55 -0500
Message-ID: <455BACB8.4010902@chelsio.com>
Date: Wed, 15 Nov 2006 16:11:36 -0800
From: divy <divy@chelsio.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] cxgb3: Chelsio T3 1G/10G ethernet device driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Nov 2006 00:11:39.0142 (UTC) FILETIME=[C9681A60:01C70913]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch adds support for the latest Chelsio adapter, T3.

Since some files are bigger than the 40kB advertized in the submit
guidelines, a monolithic patch against 2.6.19-rc5 is posted at the
following URL: http://service.chelsio.com/kernel.org/cxgb3.patch.bz2

Please advise on any other form you would like to see the code.

We wish this patch to be considered for inclusion in 2.6.20. This driver
will be required by the Chelsio T3 RDMA driver which will be posted for
review asap.

Cheers,
Divy
