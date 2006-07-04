Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbWGDJyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbWGDJyS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 05:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbWGDJyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 05:54:17 -0400
Received: from nz-out-0102.google.com ([64.233.162.205]:4588 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932183AbWGDJyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 05:54:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=BYHcu988Z9n1yJ4TVlhaYxdgoBlSqt4ZcNARLhpOYQcH2I3zSz31xHdtadAiPknZUS1Pk0Jp8CYO/DpK0azwk9h0WsQmtDSQ3nEJM6PXNwb68FekNVXpUb6bImPya/pOSHPw0lfsf+R0l4oh1KBxiOvtd4ACe0FIHUXnLw6J8Zg=
Message-ID: <17db6d3a0607040254v5fa69122wc358436783b29636@mail.gmail.com>
Date: Tue, 4 Jul 2006 15:24:16 +0530
From: "Nikhil Dharashivkar" <nikhildharashivkar@gmail.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: About mtio in Linux.
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Query is for mtio (magnetic tape IO) on linux. I found
MTIOCSETEOTMODEL ioctl on freebsd  for mtio. Is there any equivalent
IOCTl of MTIOCSETEOTMODEL in linux.
-- 
Thanks and Regards,
         Nikhil.
