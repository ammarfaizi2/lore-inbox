Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbWFHI5D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbWFHI5D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 04:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbWFHI5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 04:57:03 -0400
Received: from mx6-6.spamtrap.magma.ca ([209.217.78.149]:49602 "EHLO
	mx6-6.spamtrap.magma.ca") by vger.kernel.org with ESMTP
	id S964807AbWFHI5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 04:57:01 -0400
X-Originating-IP: [192.168.1.208]
From: "Rajeev Majumdar" <rajeevm@subextechnologies.com>
To: linux-kernel@vger.kernel.org
Subject: Problem related to Red Hat Linux kernel 2.6.9-5.EL
Date: Thu, 08 Jun 2006 14:30:21 +0550
Message-ID: <20060608.JQf.97689800@192.168.1.2>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
X-Mailer: AngleMail for eGroupWare (http://www.egroupware.org) v 1.2.002
X-magma-MailScanner-Information: Magma Mailscanner Service
X-magma-MailScanner: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ,

 I  have  a problem  with  kernel  2.6.9-5. EL  that  is enterprise
version of Red Hat linux. I am trying to run 500 or more processes
parallely with TETware distributed test harness (that can schedule processes
parallely and using its synchronisizing mechanism) but after running for
some time some processes get stuck at futex system call and waiting
infinetly that i found with strace utility.Can you please tell me whether
its bug of kernel or it has something to do with my program and setup.
If is a bug then can you tell me the patch available to fix this
problem and where can i find that...

 My machine's configuration is as follows
 Processor- P IV 3Ghz
 Ram - 2 GB

 waiting for your reply
 Regards
 Rajeev

