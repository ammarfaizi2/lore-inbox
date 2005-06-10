Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262543AbVFJMM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbVFJMM1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 08:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262371AbVFJMM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 08:12:27 -0400
Received: from lakermmtao04.cox.net ([68.230.240.35]:59625 "EHLO
	lakermmtao04.cox.net") by vger.kernel.org with ESMTP
	id S262543AbVFJMLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 08:11:18 -0400
From: Steve Snyder <swsnyder@insightbb.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PCMCIA still advised as modules?
Date: Fri, 10 Jun 2005 08:11:17 -0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506100811.17631.swsnyder@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Back in the 2.4.x kernel days I was advised to build the PCMCIA-related 
drivers (pcmcia_core, ds, yenta_socket) as modules.  There were 
supposedly problem with them being staticly built into the kernel.

Is this still the case?  Are there currently any drawbacks to having the 
PCMCIA modules built into the kernel?

Thanks.

