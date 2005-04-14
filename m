Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261287AbVDNGca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbVDNGca (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 02:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbVDNGca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 02:32:30 -0400
Received: from smartmx-06.inode.at ([213.229.60.38]:21478 "EHLO
	smartmx-06.inode.at") by vger.kernel.org with ESMTP id S261287AbVDNGc2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 02:32:28 -0400
Subject: Re: initrd support in 2.6 kernels
From: Bernhard Schauer <linux-kernel-list@acousta.at>
To: Nickolay <nickolay@protei.ru>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <425D6A97.9020300@protei.ru>
References: <425D6A97.9020300@protei.ru>
Content-Type: text/plain
Date: Thu, 14 Apr 2005 08:32:42 +0200
Message-Id: <1113460362.5526.6.camel@FC3-bernhard-1.acousta.local>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> checking if image is initramfs...it isn't (ungzip failed); looks like an 
> initrd
> Freeing initrd memory: 32768K

Hi!

Have you gzipped your initrd image? (if yes, the ungzip failed would be
a problem... btw. initramfs is a smarter way to perform the same) 

regards

