Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131362AbRCNNgB>; Wed, 14 Mar 2001 08:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131361AbRCNNfw>; Wed, 14 Mar 2001 08:35:52 -0500
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:22537 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S131352AbRCNNfe>; Wed, 14 Mar 2001 08:35:34 -0500
From: mshiju@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <CA256A0F.004A726A.00@d73mta05.au.ibm.com>
Date: Wed, 14 Mar 2001 18:35:13 +0530
Subject: ISAPNP :driver not recognized when compiled in kernel
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
           I have a basic question. Can we build a PnP ISA driver in kernel
with ISAPNP kernel option enabled so that kernel PnP does the job of
allocating the resources for the driver. The problem being that the
/etc/isapnp.conf should be executed before the device driver. I tried this
and was unsuccessful but worked fine when the driver was compiled as a
module. I read somewhere that ISAPNP drivers with ISAPNP enabled in kernel
should only be build as modules so that we can keep the order of execution
. Is this true.? Have any one of you tried this .


Thanks & Regards
Shiju



