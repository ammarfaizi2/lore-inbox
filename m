Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262144AbVC2ByX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262144AbVC2ByX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 20:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262146AbVC2ByX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 20:54:23 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:56840 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S262144AbVC2ByT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 20:54:19 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Wichert Akkerman" <wichert@wiggy.net>
Cc: "Sean" <seanlkml@sympatico.ca>, "Mark Fortescue" <mark@mtfhpc.demon.co.uk>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: Can't use SYSFS for "Proprietry" driver modules !!!.
Date: Mon, 28 Mar 2005 17:53:24 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKCEECCMAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <1111935996.8664.322.camel@localhost.localdomain>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Mon, 28 Mar 2005 17:52:37 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Mon, 28 Mar 2005 17:52:40 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The GPL is a distribution license, it doesn't really matter what you do
> *internally* with GPL code. It might be a DMCA violation in the USSA but
> thats because the law is broken.

	You can't violate the DMCA on a GPL'd work. At least, if there's a way to
do, I couldn't find it. See some of the previous posts on this list about
whether the DMCA meant you couldn't remove the GPL tag on exported symbols.
The GPL explicitly permits you to modify the code as you wish, and this
includes removing any restriction or enforcement type code.

	DS


