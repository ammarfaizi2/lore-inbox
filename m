Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261990AbULPTEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261990AbULPTEU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 14:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbULPTBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 14:01:40 -0500
Received: from mx1.redhat.com ([66.187.233.31]:11468 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261990AbULPTAH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 14:00:07 -0500
Date: Thu, 16 Dec 2004 11:00:02 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: debugfs in the namespace
Message-ID: <20041216110002.3e0ddf52@lembas.zaitcev.lan>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

what is the canonic place to mount debugfs: /debug, /debugfs, or anything
else? The reason I'm asking is that USBMon has to find it somewhere and
I'd really hate to see it varying from distro to distro.

Thanks,
-- Pete
