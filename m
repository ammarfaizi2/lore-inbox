Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbTFTCZF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 22:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262171AbTFTCZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 22:25:05 -0400
Received: from fmr06.intel.com ([134.134.136.7]:34796 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S262170AbTFTCZB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 22:25:01 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780E040A12@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Robert Love'" <rml@tech9.net>, "'Joe Korty'" <joe.korty@ccur.com>
Cc: "'george anzinger'" <george@mvista.com>,
       "'Andrew Morton'" <akpm@digeo.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'mingo@elte.hu'" <mingo@elte.hu>, "Li, Adam" <adam.li@intel.com>
Subject: RE: [patch] setscheduler fix
Date: Thu, 19 Jun 2003 19:38:57 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Robert Love [mailto:rml@tech9.net]
> 
> Here is my patch. It is the same idea as Joe's. Is there a better fix?

Fixes my sched-hang.c

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)

