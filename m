Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261656AbVCYOtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbVCYOtO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 09:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbVCYOtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 09:49:13 -0500
Received: from smartmx-03.inode.at ([213.229.60.35]:14044 "EHLO
	smartmx-03.inode.at") by vger.kernel.org with ESMTP id S261656AbVCYOtL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 09:49:11 -0500
Subject: Re: INITRAMFS: junk in compressed archive
From: Bernhard Schauer <linux-kernel-list@acousta.at>
Reply-To: schauer@acousta.at
To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1111679972.5628.10.camel@FC3-bernhard-1.acousta.local>
References: <1111679972.5628.10.camel@FC3-bernhard-1.acousta.local>
Content-Type: text/plain
Date: Fri, 25 Mar 2005 15:49:29 +0100
Message-Id: <1111762170.7238.3.camel@FC3-bernhard-1.acousta.local>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

other question:

Is there any size-limit on initramfs image? I found out that after
reducing the image size it is loaded & /init executed as expected...

