Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313800AbSDPSGi>; Tue, 16 Apr 2002 14:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313801AbSDPSGi>; Tue, 16 Apr 2002 14:06:38 -0400
Received: from ccs.covici.com ([209.249.181.196]:21392 "EHLO ccs.covici.com")
	by vger.kernel.org with ESMTP id <S313800AbSDPSGg>;
	Tue, 16 Apr 2002 14:06:36 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.5.8 undefined symbol setup_per_cpu_areas
From: John Covici <covici@ccs.covici.com>
Date: Tue, 16 Apr 2002 14:06:35 -0400
Message-ID: <m3bscjwmac.fsf@ccs.covici.com>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) Emacs/21.2.50
 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using 2.5.8 and I enabled the machine check and
non-fatal-messages and I get the following error at the end of
bzImage make:

init/main.o: In function `start_kernel':
init/main.o(.text.init+0x64a): undefined reference to `setup_per_cpu_areas'

Any assistance would be appreciated.
-- 
         John Covici
         covici@ccs.covici.com
