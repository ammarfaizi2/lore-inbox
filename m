Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbWEIUUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbWEIUUA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 16:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbWEIUUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 16:20:00 -0400
Received: from [194.90.237.34] ([194.90.237.34]:47708 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S1751121AbWEIUT7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 16:19:59 -0400
Date: Tue, 9 May 2006 23:20:41 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Shirley Ma <xma@us.ibm.com>
Cc: Heiko J Schick <info@schihei.de>, Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       Marcus Eder <MEDER@de.ibm.com>, openib-general@openib.org,
       openib-general-bounces@openib.org, Christoph Raisch <RAISCH@de.ibm.com>,
       Roland Dreier <rdreier@cisco.com>
Subject: Re: [openib-general] Re: [PATCH 07/16] ehca: interrupt handling	routines
Message-ID: <20060509202041.GB24713@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <40FCD6B6-9135-43C1-8974-E9070475DB78@schihei.de> <OF6CAB9865.804CAFBB-ON87257169.006C3DBC-88257169.00718277@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF6CAB9865.804CAFBB-ON87257169.006C3DBC-88257169.00718277@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 09 May 2006 20:23:41.0546 (UTC) FILETIME=[767014A0:01C673A6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Shirley Ma <xma@us.ibm.com>:
> My understanding is NAPI handle interrutps CQ callbacks on the same CPU.

My understanding is NAPI disables interrupts under high RX load. No?

-- 
MST
