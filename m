Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312983AbSC0G7K>; Wed, 27 Mar 2002 01:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312690AbSC0G7A>; Wed, 27 Mar 2002 01:59:00 -0500
Received: from ccs.covici.com ([209.249.181.196]:46209 "EHLO ccs.covici.com")
	by vger.kernel.org with ESMTP id <S312977AbSC0G6z>;
	Wed, 27 Mar 2002 01:58:55 -0500
To: alsa-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: shutting down alsa causes paging exception
From: John Covici <covici@ccs.covici.com>
Date: Wed, 27 Mar 2002 01:58:46 -0500
Message-ID: <m37knymr89.fsf@ccs.covici.com>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) Emacs/21.1.90
 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using the alsa which is integrated into the 2.5.7 kernel and I am
getting unable to handle kernel paging whenever I try to shutdown the
alsa drivers.  I have it as modules and I think it can't delete the
module.  I can supply the log entries if that would help.

I am using the via8233 modules.

Any assistance would be appreciated.

-- 
         John Covici
         covici@ccs.covici.com
