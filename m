Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313585AbSDQTfC>; Wed, 17 Apr 2002 15:35:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313586AbSDQTfB>; Wed, 17 Apr 2002 15:35:01 -0400
Received: from ccs.covici.com ([209.249.181.196]:22934 "EHLO ccs.covici.com")
	by vger.kernel.org with ESMTP id <S313585AbSDQTfA>;
	Wed, 17 Apr 2002 15:35:00 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.5.8 nbd.c doesn't compile
From: John Covici <covici@ccs.covici.com>
Date: Wed, 17 Apr 2002 15:34:59 -0400
Message-ID: <m33cxuw23g.fsf@ccs.covici.com>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) Emacs/21.2.50
 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I try to compile 2.5.8 with nbd as a module, I get lots of error
saying structure has no member queue_lock .

Any assistance would be appreciated.

-- 
         John Covici
         covici@ccs.covici.com
