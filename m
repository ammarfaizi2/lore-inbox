Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265133AbUGGOGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265133AbUGGOGz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 10:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265137AbUGGOGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 10:06:55 -0400
Received: from mail1.village.telecomitalia.it ([195.14.96.132]:5894 "EHLO
	village.telecomitalia.it") by vger.kernel.org with ESMTP
	id S265133AbUGGOGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 10:06:54 -0400
Message-ID: <40EC045F.6010901@gandalf.sssup.it>
Date: Wed, 07 Jul 2004 16:10:39 +0200
From: michael trimarchi <trimarchi@gandalf.sssup.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Kernel_Thread
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
is it possible to allocate a private stack for a kernel_thread passing 
the block allocated in the do_fork call?

Best regards
Michael

