Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264405AbUD0XYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264405AbUD0XYe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 19:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264408AbUD0XYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 19:24:34 -0400
Received: from mail.fastclick.com ([205.180.85.17]:10719 "EHLO
	mail.fastclick.net") by vger.kernel.org with ESMTP id S264405AbUD0XYd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 19:24:33 -0400
Message-ID: <408EEBAF.7020603@fastclick.com>
Date: Tue, 27 Apr 2004 16:24:31 -0700
From: "Brett E." <brettspamacct@fastclick.com>
Reply-To: brettspamacct@fastclick.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: How to tune pdflush?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to tune pdflush so the writeback isn't too greedy, right 
now the system is unusable due to high disk I/O after creating a bunch 
of files. I know, faster disks would be better.. Tuning the writeback 
would also be a nice option, we had it in 2.4 with /proc/sys/vm/bdflush.


Thanks,

Brett

