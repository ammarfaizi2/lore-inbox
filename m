Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264036AbTH1Nsn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 09:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264037AbTH1Nsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 09:48:43 -0400
Received: from kogut.o2.pl ([212.126.20.60]:13473 "EHLO kogut.o2.pl")
	by vger.kernel.org with ESMTP id S264036AbTH1Nsm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 09:48:42 -0400
From: Tomasz Czaus <tomasz_czaus@go2.pl>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test4 and hardware reports a non fatal incident
Date: Thu, 28 Aug 2003 15:48:44 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308281548.44803.tomasz_czaus@go2.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

when my system is booting I can see such a message:

kernel: MCE: The hardware reports a non fatal, correctable incident occurred 
on CPU 0.
kernel: Bank 0: e664000000000185

What does it mean ??? My kernel 2.6.0-test4 has applyed "Nick's scheduler 
policy v8" patch. 

When I boot 2.4.x kernel I can't see this message.


Thanks,
Tomasz Czaus

