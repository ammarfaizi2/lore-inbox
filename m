Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275839AbRI1G5c>; Fri, 28 Sep 2001 02:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275855AbRI1G5W>; Fri, 28 Sep 2001 02:57:22 -0400
Received: from mailhub-2.iastate.edu ([129.186.140.4]:36882 "EHLO
	mailhub-2.iastate.edu") by vger.kernel.org with ESMTP
	id <S275839AbRI1G5O>; Fri, 28 Sep 2001 02:57:14 -0400
Message-Id: <200109280657.f8S6vbBG010382@mailhub-2.iastate.edu>
To: linux-kernel@vger.kernel.org
Cc: rmurali@iastate.edu
From: Murali Ravirala <rmurali@iastate.edu>
Subject: copy_from_user() overhead
Date: Fri, 28 Sep 2001 01:57:40 -0500 (CDT)
X-Mailer: Endymion MailMan Professional Edition v3.0.14 ISU Version mp5.34
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We are interested in finding out the overhead in kernel->user buffer copy and
vice-versa for disk reads and network writes resp. in copy_from_user() and
copy_to_user() calls. Are there any quantitative data available for this? We
plan to eliminate this overhead, if significant, in our integrated disk-read and
network-write architecture. Any pointers/references related to this type of
work?

TIA,
Murali.

