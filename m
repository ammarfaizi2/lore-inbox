Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266003AbUGTQqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266003AbUGTQqR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 12:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266004AbUGTQqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 12:46:17 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:7601 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266003AbUGTQqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 12:46:15 -0400
Message-ID: <40FD4C4E.7080205@yahoo.com.au>
Date: Wed, 21 Jul 2004 02:46:06 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.8-rc1-np3
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://www.kerneltrap.org/~npiggin/2.6.8-rc1-np3/

More memory management and scheduler work. More to come. The
-rc1 patch should hopefully just apply to -rc2.

Again, the scheduler timeslice is set quite large, so adjust
/proc/sys/kernel/base_timeslice down to probably 64 or 32 for
good desktop results. Also renice X to -10.

