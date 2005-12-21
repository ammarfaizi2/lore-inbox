Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbVLUFRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbVLUFRi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 00:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbVLUFRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 00:17:37 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:37039 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751111AbVLUFRg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 00:17:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=uPAtPCYV+m/ZFsw21AO08IV/NIIvhfHlj8d/0TML1v/a/aZMmBsXOrzEzvKVXQUdQ2WVSo7keeOkwgXqacEmTXHyhPkbIZYs2eQPOOoxflCKGXx/3SD5q6u/tytyP8tiSsNTx8WfUmIpPmJbs0E+AXzZnUbrR/wEKBsGsSR1O4Q=
Message-ID: <489ecd0c0512202117q303ef7f1qae6bc08c9637be39@mail.gmail.com>
Date: Wed, 21 Dec 2005 13:17:35 +0800
From: Luke Yang <luke.adi@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: kernel development process questions
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

   Thanks for Greg's howto and others' documents (Such as the "kernel
hacker's guide to git). But I still have some detail questions:

   Which is everyone working on: the "latest linus git tree" or the
"-mm kernel"? As I tried, the -mm kernel is only a patch, which MAY
can not be applied to latest kernel. For example, current
2.6.15-rc5-mm3 patch can't be applied to  current kernel without
rejections and conflicts.

   As Greg pointed out, most patches should be tested on -mm kernel.
So I assum that a developer just get an exact 2.6.15-rc5 kernel from
git, apply the 2.6.15-rc5-mm3 patch, do some work and send out the
patch, then just stay there for next -mm patch?

   Thanks in advace!

BTW:  git question, Is there any way to get my .git/refs/ folder
updated through http? I mean not through rsync?

Regards,
Luke Yang
Analog Device Inc.
