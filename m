Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbTH3BZO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 21:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbTH3BZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 21:25:14 -0400
Received: from mail.webmaster.com ([216.152.64.131]:14529 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S262217AbTH3BZM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 21:25:12 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <Valdis.Kletnieks@vt.edu>, "don fisher" <dfisher@as.arizona.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: How to choose between ip 2 identical ethernet cards 
Date: Fri, 29 Aug 2003 18:24:50 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKGEMLFNAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
In-Reply-To: <200308300046.h7U0k8m8011982@turing-police.cc.vt.edu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Fri, 29 Aug 2003 17:29:29 PDT, don fisher
> <dfisher@as.arizona.edu>  said:

> The magic under a RedHat system happens in:
>
> /etc/sysconfig/network-scripts/ifup
>
> Hope that helps.

	Yep, quite painless. Just specify the mac address in the 'ifcfg-<name>'
configuration file.

	DS


