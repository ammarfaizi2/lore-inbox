Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264383AbTLYWmj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 17:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264386AbTLYWmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 17:42:38 -0500
Received: from fmx2.freemail.hu ([195.228.242.222]:34173 "HELO
	fmx2.freemail.hu") by vger.kernel.org with SMTP id S264383AbTLYWmh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 17:42:37 -0500
Date: Thu, 25 Dec 2003 23:42:36 +0100 (CET)
From: Max Payne <"max..payne"@freemail.hu>
Subject: psmouse.c: Mouse at isa0060/serio4/input0 lost sync
To: linux-kernel@vger.kernel.org
Message-ID: <freemail.20031125234236.57189@fm4.freemail.hu>
X-Originating-IP: [81.182.117.36]
X-HTTP-User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've a long standing problem with 2.5/2.6 kernel series. My
mouse sometimes moving weird under X. In the syslog I found
related kernel message:

Dec 25 23:31:04 yavin4 kernel: psmouse.c: Mouse at
isa0060/serio4/input0 lost synchronization, throwing 2 bytes
away.

It seems the problem related gkrellm+apm. If the gkrellm
running the mouse weird moving oftener.

My machine an IBM Thinkpad R32. The problem continously
exist from 2.5.70 -> 2.6.0-mm1.

Any idea? 

Thanks for your attention. 
 
Max.


