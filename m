Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265234AbUE0VDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265234AbUE0VDG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 17:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265242AbUE0VDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 17:03:06 -0400
Received: from outmx006.isp.belgacom.be ([195.238.2.99]:4764 "EHLO
	outmx006.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S265234AbUE0VDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 17:03:04 -0400
Subject: ext3 readdir
From: FabF <fabian.frederick@skynet.be>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1085691851.2070.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 27 May 2004 23:04:11 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Someone could explain why we don't have the "ext2 dir.c moved to use
pagecache" applied to ext3 as well ? Does it have something to do with
journaling ?

Regards,
FabF

