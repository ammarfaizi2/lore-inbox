Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284180AbSAPRZG>; Wed, 16 Jan 2002 12:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284264AbSAPRY7>; Wed, 16 Jan 2002 12:24:59 -0500
Received: from mgr1.xmission.com ([198.60.22.201]:57861 "EHLO
	mgr1.xmission.com") by vger.kernel.org with ESMTP
	id <S284902AbSAPRYD>; Wed, 16 Jan 2002 12:24:03 -0500
Message-ID: <3C45B712.8090402@xmission.com>
Date: Wed, 16 Jan 2002 10:23:30 -0700
From: Frank Jacobberger <f1j@xmission.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011225
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Unresolved symbols in sysv.o on 2.4.18-pre4
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting:

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.18-pre4; fi
depmod: *** Unresolved symbols in 
/lib/modules/2.4.18-pre4/kernel/fs/sysv/sysv.o
depmod:     waitfor_one_page

Any patch or work around here?

Thanks.

Frank

