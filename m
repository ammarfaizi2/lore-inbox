Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269083AbUINAip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269083AbUINAip (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 20:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269075AbUINAip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 20:38:45 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:40104 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S269083AbUINAim convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 20:38:42 -0400
Message-ID: <41460CC3.6000201@free.fr>
Date: Mon, 13 Sep 2004 23:10:27 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-2.6.9-rc2 : hardirq.h broken if PREEMPT enabled
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig  posted this patch but it was unfortunately not 
included in linux-2.6.9-rc2. As I see oops reports with PREEMPT enabled, 
I think people should make sure to apply this patch first.

<http://www.ussg.iu.edu/hypermail/linux/kernel/0409.1/1227.html>

My 0.02 ¤ :-)

-- eric


