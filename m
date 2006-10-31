Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423462AbWJaPDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423462AbWJaPDR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 10:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423463AbWJaPDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 10:03:17 -0500
Received: from nz-out-0102.google.com ([64.233.162.194]:63664 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1423462AbWJaPDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 10:03:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=QJp20mE3LXM5dTDXc70cIXhzxS+ValDslJPFczFCVQPEmmioQgsbG9ju0g3+WHE4E9E0sXNc3ihOs1Rlb5G1iHIURccdM7UPemXovW/kxeIVmRVUeW8pvsU/VW8O5BzwJksLflPWutOwij7mjDearV16V7T7cqUMonroBl1j3ec=
Message-ID: <53f38ab60610310703p65084dc4w9be16a996da44a70@mail.gmail.com>
Date: Tue, 31 Oct 2006 20:33:15 +0530
From: "adheer chandravanshi" <adheerchandravanshi@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: huge page corner cases???
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all,

I am a Linux newbie.

I read about the huge page corner cases i.e problems may occur on
using hueg pages in Linux , the linux of the page is:
http://linux-mm.org/HugePageCornerCases

The first corner case is given as

-NUMA-aware allocation - don't want all the memory accesses going
through a common controller.

Can anyone please specify what the statement means as I didn't clearly
get its meaning? And what can be a possible solution for it?


-Adheer
