Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbUDWUGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUDWUGz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 16:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbUDWUGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 16:06:55 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:63492 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S261239AbUDWUGy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 16:06:54 -0400
Message-ID: <85D529CA.7DFC5911@mail.gmail.com>
Date: Fri, 23 Apr 2004 13:06:49 -0700
From: Chris Walker <cwalkatron@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20 and 2.4.24 report different memory sizes
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have two identical machines each with 4GB of memory, one running
2.4.20 and 2.4.24.
According to /proc/meminfo (MemTotal):

2.4.20 : 4138912kB
2.4.24 : 3879708kB

What might explain this difference? Let me know if you need more information.

Thanks

--
Chris Walker
Render Pipeline Group
Pixar Animation Studios
510/752.3736
cwalker@pixar.com
cwalkatron@gmail.com
