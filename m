Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285302AbRLNBWx>; Thu, 13 Dec 2001 20:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285303AbRLNBWn>; Thu, 13 Dec 2001 20:22:43 -0500
Received: from topaz.3com.com ([192.156.136.158]:6330 "EHLO topaz.3com.com")
	by vger.kernel.org with ESMTP id <S285302AbRLNBW0>;
	Thu, 13 Dec 2001 20:22:26 -0500
Subject: fd_setsize
To: linux-kernel@vger.kernel.org
From: Hui_Ning@3com.com
Date: Thu, 13 Dec 2001 19:22:34 -0600
Message-ID: <OFB046FAEF.D6FAB48A-ON86256B22.00075ECB@3com.com>
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi,

I am using 2.4 kernel. How can I increase the fd_setsize so that I can use
select to check more than 1024 file descriptors?

thanks,

hui

