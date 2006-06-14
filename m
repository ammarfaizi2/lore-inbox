Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964889AbWFNJzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbWFNJzT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 05:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbWFNJzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 05:55:18 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44479 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964889AbWFNJzR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 05:55:17 -0400
Subject: RE: binary portability
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Majumder, Rajib" <rajib.majumder@credit-suisse.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <F444CAE5E62A714C9F45AA292785BED30EB971C4@esng11p33001.sg.csfb.com>
References: <F444CAE5E62A714C9F45AA292785BED30EB971C4@esng11p33001.sg.csfb.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 14 Jun 2006 11:11:10 +0100
Message-Id: <1150279870.3490.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-06-14 am 16:34 +0800, ysgrifennodd Majumder, Rajib:
> Hi,
> 
> Thanks for the clarifications. Just had 1 more question. Can I port binaries built on RHEL 3/Opteron(2.4.21) to SLES 9/Opteron (2.6.5-7.252) and run without any issues?  

Generally speaking - yes. C++ may be trickier in some cases

http://www.freestandards.org/en/LSB

