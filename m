Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293498AbSCFMCt>; Wed, 6 Mar 2002 07:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293500AbSCFMCk>; Wed, 6 Mar 2002 07:02:40 -0500
Received: from tartu.cyber.ee ([193.40.6.68]:45842 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id <S293498AbSCFMCg>;
	Wed, 6 Mar 2002 07:02:36 -0500
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.6-pre2 IDE cleanup 16
In-Reply-To: <3C85F872.7050306@evision-ventures.com>
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.18 (i586))
Message-Id: <E16ia7t-0000N9-00@roos.tartu-labor>
Date: Wed, 06 Mar 2002 14:02:33 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MD> 2. It convinced me that the current task-file interface in linux
MD>     is inadequate. So Alan please bear with me if your CF format
MD>     microdrive will have to not wakeup properly for some time...
MD>     The current mess will just have to go before something more
MD>     adequate can go in.

Why not keep the existing taskfile implementation in until you complete the
elegant implementation?

-- 
Meelis Roos (mroos@tartu.cyber.ee)
