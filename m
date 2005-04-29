Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262541AbVD2NGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262541AbVD2NGz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 09:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262551AbVD2NGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 09:06:54 -0400
Received: from ozlabs.org ([203.10.76.45]:56536 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262541AbVD2NGx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 09:06:53 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17010.12654.630130.252581@cargo.ozlabs.ibm.com>
Date: Fri, 29 Apr 2005 23:06:54 +1000
From: Paul Mackerras <paulus@samba.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 3/4] ppc64: Add driver for BPA iommu
In-Reply-To: <200504291031.59223.arnd@arndb.de>
References: <200504190318.32556.arnd@arndb.de>
	<200504290748.30055.arnd@arndb.de>
	<1114756984.7111.268.camel@gaston>
	<200504291031.59223.arnd@arndb.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann writes:

> Implementation of software load support for the BE iommu. This is very

Could you expand a bit on what "software load support" is?  Your
description is a bit terse.

Thanks,
Paul.
