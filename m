Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbVGGNX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbVGGNX1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 09:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbVGGNR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 09:17:56 -0400
Received: from ece.iisc.ernet.in ([144.16.64.2]:19212 "EHLO ece.iisc.ernet.in")
	by vger.kernel.org with ESMTP id S261459AbVGGNPr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 09:15:47 -0400
From: anand@eis.iisc.ernet.in (SVR Anand)
Message-Id: <200507071315.SAA09068@eis.iisc.ernet.in>
Subject: Can Linux remain to be general purpose OS ?
To: linux-kernel@vger.kernel.org
Date: Thu, 7 Jul 2005 18:45:30 +0530 (GMT+05:30)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been following Linux kernel development for many years. Of late there seems to be a
general trend in expecting Linux kernel to do specialized tasks to cater to specific end-user
applications. This could even mean that the kernel algorithms that make Linux a generic OS
may have to be customized to serve these specialized needs which would not be possible 
otherwise. Thinking aloud, would it make sense to make Linux kernel take a different "avatar"
depending on the user specificities, say through a configurable option while building the 
kernel, or a heuristic or any other approach ?

The above concern is motivated by growing expectations from the community to use Linux not
merely as a general purpose OS but in specific environments as well. One could argue that
there could be many specific variants possible, but if we could capture some of them that 
could serve the purpose in most cases.

Please pardon me if I have sounded too generic. I hope I have conveyed basic idea.

Thanks.

Regards
Anand
