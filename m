Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262179AbVGLTz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbVGLTz3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 15:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262330AbVGLTz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 15:55:29 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:34463 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262179AbVGLTz0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 15:55:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=suL5aJUlmBQdZXe/dR2q5eKolzkdcha+4KZo/JXIbgHyEV2aTC3a4jblK+XFOwsTuDoKvIdbd/S03c0ohyYDZk7ck29la7WxJhAzjAnthNZL5XXbcHBAn1DnwtbAVl8Dj1GuWUesfGOWnmFEyNLSGg6xU21zFpG4lzDOiyDxLEs=
Message-ID: <42D4201A.9050303@gmail.com>
Date: Tue, 12 Jul 2005 15:55:06 -0400
From: Keenan Pepper <keenanpepper@gmail.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: realtime-preempt + reiser4?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar's realtime-preempt patches used to be based on the -mm 
kernels, but now they appear to be based on the mainline kernels, so 
they don't support reiser4 (at least until reiser4 is merged into 
mainline, which is looking uncertain as I understand it).
Is realtime-preempt-2.6.10-mm1-V0.7.34-01 the most recent 
realtime-preempt kernel to support reiser4?
How is the latency of the reiser4 code itself?

Keenan
