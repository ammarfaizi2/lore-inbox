Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261765AbVASQFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261765AbVASQFg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 11:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbVASQEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 11:04:05 -0500
Received: from asplinux.ru ([195.133.213.194]:15372 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S261765AbVASQD7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 11:03:59 -0500
Message-ID: <41EE85CC.3020009@sw.ru>
Date: Wed, 19 Jan 2005 19:07:40 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: possible CPU bug and request for Intel contacts
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Linus, Ingo, I've got one strange CPU bug leading to oopses, reboots and 
so on. This bug can be reproduced with a little bit modified 4gb split 
and is probably related to CPU speculative execution. I'll post more 
information about this bug later, but I would like to ask you for Intel 
guys contacts who maybe interested in this information, so I could CC 
them as well.

Thank you,
Kirill

