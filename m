Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbTDQJ7C (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 05:59:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbTDQJ7C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 05:59:02 -0400
Received: from [218.4.63.7] ([218.4.63.7]:2834 "EHLO mitac-mkl.com.cn")
	by vger.kernel.org with ESMTP id S261302AbTDQJ7C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 05:59:02 -0400
Message-ID: <3E9E7D91.5D68C325@mic.com.tw>
Date: Thu, 17 Apr 2003 18:10:25 +0800
From: "rain.wang" <rain.wang@mic.com.tw>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21pre7-ac1
References: <200304141616.h3EGG1K22074@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-MDRemoteIP: 127.0.0.1
X-Return-Path: rain.wang@mic.com.tw
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    Race still exist in ide drive reset path, system 
crashed with "kernel BUG at ide.c:1692!"...

rain.w

