Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265128AbTLWNBc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 08:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265129AbTLWNBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 08:01:32 -0500
Received: from main.gmane.org ([80.91.224.249]:26571 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265128AbTLWNBa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 08:01:30 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Per Jessen <per@computer.org>
Subject: Re: make menuconfig loops ??
Date: Tue, 23 Dec 2003 14:01:27 +0100
Message-ID: <bs9eb7$hsm$1@sea.gmane.org>
References: <20031221144427.57D00DAA81@mail.local.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Per Jessen wrote:

> I have a problem when trying to build a kernel. It appears that make
> menuconfig starts to loop -
> after writing "Preparing scripts: functions, parsing ...done."
> This is 2.4.23, jfs114, gcc3.3.2.

All, this problem has now miraculously disappeared!  Obviously I must've
changed something, I just can't think of what it might have been.  


/Per


-- 
Per Jessen, Zurich
http://www.dansklisten.org - for alle danskere i udlandet!

