Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316770AbSHJJ4a>; Sat, 10 Aug 2002 05:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316775AbSHJJ4a>; Sat, 10 Aug 2002 05:56:30 -0400
Received: from p3E99065B.dip.t-dialin.net ([62.153.6.91]:55565 "EHLO
	salem.getuid.de") by vger.kernel.org with ESMTP id <S316770AbSHJJ43>;
	Sat, 10 Aug 2002 05:56:29 -0400
Date: Sat, 10 Aug 2002 11:08:26 +0200
From: Christian Kurz <shorty@getuid.de>
To: linux-kernel@vger.kernel.org
Subject: unix.o missing module license
Message-ID: <20020810090826.GL23894@salem.getuid.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: True happiness will be found only in true love.
Mail-Copies-To: never
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

while playing with lsmod and modinfo I noticed that the module unix.o
doesn't have any license information, also it lacks information about
the authors:

|[salem:~]-30> modinfo unix                                                
|filename:    /lib/modules/2.4.20-pre1/kernel/net/unix/unix.o
|description: <none>
|author:      <none>
|license:     <none>

I would appreciate if at least the license and even better also some
author name would be added. Thanks.

Christian
-- 
We must learn to live together like brothers,
or we shall die together like fools.
                -- Martin Luther King
