Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbTHTLwY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 07:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261978AbTHTLwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 07:52:24 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:62435 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261973AbTHTLwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 07:52:19 -0400
Message-ID: <3F4360F0.209@gamic.com>
Date: Wed, 20 Aug 2003 13:52:16 +0200
From: Sergey Spiridonov <spiridonov@gamic.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: how to turn off, or to clear read cache?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I need to make some performance tests. I need to switch off or to clear 
read cache, so that consequent reading of the same file will take the 
same amount of time.

Is there an easy way to do it, without rebuilding the kernel?

Please, put me on CC since I'm not subscriber of linux-kernel
-- 
Best regards, Sergey Spiridonov

