Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbVHWVQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbVHWVQR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932066AbVHWVQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:16:17 -0400
Received: from ms-smtp-01-smtplb.rdc-nyc.rr.com ([24.29.109.5]:34776 "EHLO
	ms-smtp-01.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S932143AbVHWVQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:16:16 -0400
Date: Tue, 23 Aug 2005 17:16:05 -0400 (EDT)
Message-Id: <200508232116.j7NLG51g028312@ms-smtp-01.rdc-nyc.rr.com>
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-URL: mailto:linux-kernel@vger.kernel.org
X-Mailer: Lynx, Version 2.8.6dev.13a
From: robotti@godmail.com
Subject: Initramfs and TMPFS!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Why doesn't initramfs use tmpfs instead of ramfs, because
tmpfs is more robust?

I know tmpfs is larger, but at least it should be an option.

Also, tar should be an option instead of cpio for the archiver,
because tar is more widely used.

