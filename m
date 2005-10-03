Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932501AbVJCSZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbVJCSZx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 14:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932499AbVJCSZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 14:25:53 -0400
Received: from 80-218-222-113.dclient.hispeed.ch ([80.218.222.113]:21916 "EHLO
	steudten.com") by vger.kernel.org with ESMTP id S932495AbVJCSZw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 14:25:52 -0400
Message-ID: <434177A4.8070101@steudten.org>
Date: Mon, 03 Oct 2005 20:25:40 +0200
From: "alpha @ steudten Engineering" <alpha@steudten.com>
Organization: Steudten Engineering
MIME-Version: 1.0
To: LinuxAlpha <linux-alpha@vger.kernel.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: kernel-2.6.13.2: MISSING: asm-alpha/diskdump.h
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: Mailer
X-Check: 2c1783c72b2809387bfafaa1e08e3128 on steudten.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The file asm-alpha/diskdump.h is missing in the 2.6.13 patch .2
build for alpha arch.

The build breaks also with # CONFIG_DISKDUMP is not set

Thomas
