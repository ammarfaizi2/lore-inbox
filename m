Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261732AbVFMQTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbVFMQTq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 12:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbVFMQTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 12:19:46 -0400
Received: from smtp-101-monday.noc.nerim.net ([62.4.17.101]:44817 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S261732AbVFMQTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 12:19:42 -0400
Date: Mon, 13 Jun 2005 18:19:45 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Cc: Andrew Morton <akpm@osdl.org>, video4linux-list@redhat.com,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fixes removal of normal_i2c_range on V4L
Message-Id: <20050613181945.76a3da6b.khali@linux-fr.org>
In-Reply-To: <42ACF624.3050904@brturbo.com.br>
References: <42ACF389.40205@brturbo.com.br>
	<42ACF624.3050904@brturbo.com.br>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

> This patch is necessary to correct I2C detect after normal_i2c_range
> removal applied by  gregkh-i2c-i2c-address_range_removal.patch at -mm
> series.

No. Check 2.6.12-rc6-mm1, it already has all these changes. You must
have messed up somewhere.

-- 
Jean Delvare
