Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbVGATy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbVGATy3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 15:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbVGATy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 15:54:28 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:33781 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262377AbVGATxQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 15:53:16 -0400
Message-ID: <42C59EDD.2080206@mvista.com>
Date: Fri, 01 Jul 2005 12:51:57 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Question about patch order
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suppose I am doing this prior to my morning coffee, but...

What should the -rc patch(s) be applied to?  Should it be
2.6.x or 2.6.x.n
e.g. the 2.6.12 kernel or the 2.6.12.2 kernel?

If the former, does the -rc contain the .n stuff?


-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
