Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261407AbVC0HiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbVC0HiY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 02:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVC0HiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 02:38:24 -0500
Received: from irc.sh.nu ([216.239.132.110]:57286 "EHLO mail.3gstech.com")
	by vger.kernel.org with ESMTP id S261408AbVC0HiW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 02:38:22 -0500
Subject: Re: Kernel 2.6.11.5 doesn't recognize Plextor 712 SATA DVD burner
From: Aaron Gyes <floam@sh.nu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sat, 26 Mar 2005 23:38:20 -0800
Message-Id: <1111909100.17499.0.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You've tried applying the libata-dev patche, right? You need it for
ATAPI support.

