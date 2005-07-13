Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262931AbVGMPZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262931AbVGMPZn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 11:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262909AbVGMPZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 11:25:34 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:36125 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262681AbVGMPXX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 11:23:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=CO1yhlUNiHSSqpbgFuSyyOl/SIxnqO9Rb+NXkof40sVAFkRryPFSPdHCP9SreTQbl4Mwqwga+kW4zMPc/hpI1gC6zy5DXljGAGB6PqrNJaHKDoolO1Y5BOlBTqsGm2Ar9XX5WTNdLFpLuWGCEBMXZjsA03bP7iciOQcCRVW0RfA=
Message-ID: <a44ae5cd05071308224b39aad5@mail.gmail.com>
Date: Wed, 13 Jul 2005 10:22:35 -0500
From: Miles Lane <miles.lane@gmail.com>
Reply-To: Miles Lane <miles.lane@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: 2.6.13-rc2-mm2 -- include/linux/mtd/xip.h:68:25: error: asm/mtd-xip.h: No such file or directory
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In file included from drivers/mtd/chips/cfi_probe.c:18:
include/linux/mtd/xip.h:68:25: error: asm/mtd-xip.h: No such file or directory
