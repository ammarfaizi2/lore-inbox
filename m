Return-Path: <linux-kernel-owner+w=401wt.eu-S1751361AbXAFLma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbXAFLma (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 06:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbXAFLma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 06:42:30 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:61964 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361AbXAFLm3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 06:42:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=tUyWqSSj1l+bl7JAKewjbrWLkwsDsEWGRxNwoJk3K9Ggyd9FUwxCAs+BPQVmcBzzqFYk7eodx/yVjJ630bNCH3DcTSEgPaHd9CVE1TQDTRKBWopfZfODOrnZm5vSenkbzFNtvuDx4dzj03fhiTrQb7sT01rc0hZSJXpm1ayqqcY=
Message-ID: <cc723f590701060342o2ea5016es1ab6faff45486dba@mail.gmail.com>
Date: Sat, 6 Jan 2007 17:12:27 +0530
From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
To: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: sysrq_always_enabled boot option ??
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is about commit 5d6f647fc6bb57377c9f417c4752e43189f56bb1.
Why is this change needed. As far as i understand from the
the commit message distro used to set sysrq_enabled = 0.
But they if we need sysrq support we can set it using sysctl
why do we need a kernel command line option ?

-aneesh
