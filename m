Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265623AbRF1KUB>; Thu, 28 Jun 2001 06:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265626AbRF1KTu>; Thu, 28 Jun 2001 06:19:50 -0400
Received: from [202.54.26.202] ([202.54.26.202]:14977 "EHLO hindon.hss.co.in")
	by vger.kernel.org with ESMTP id <S265623AbRF1KTk>;
	Thu, 28 Jun 2001 06:19:40 -0400
X-Lotus-FromDomain: HSS
From: alad@hss.hns.com
To: linux-kernel@vger.kernel.org
Message-ID: <65256A79.0038FC3A.00@sandesh.hss.hns.com>
Date: Thu, 28 Jun 2001 15:49:17 +0530
Subject: Why we need LDT at all in 2.2 kernels ??
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,
     In 2.2 kernel do we really need its own LDT (not default_ldt) for every
process (no mm sharing) ??

In what circumstances a process may need its own LDT ??

--
Amol


