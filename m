Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbTIKI47 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 04:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbTIKI47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 04:56:59 -0400
Received: from iv.ro ([194.105.28.94]:33569 "HELO iv.ro") by vger.kernel.org
	with SMTP id S261171AbTIKI46 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 04:56:58 -0400
Date: Thu, 11 Sep 2003 11:45:57 +0300
From: Jani Monoses <jani@iv.ro>
To: linux-kernel@vger.kernel.org
Subject: about kernel/ksyms.c
Message-Id: <20030911114557.219e45b7.jani@iv.ro>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

what is the reason for symbols being exported from ksyms.c instead of
the files they are defined in?

thanks
Jani 

