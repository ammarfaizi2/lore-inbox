Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310194AbSCSGSu>; Tue, 19 Mar 2002 01:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310206AbSCSGSk>; Tue, 19 Mar 2002 01:18:40 -0500
Received: from ccs.covici.com ([209.249.181.196]:16513 "EHLO ccs.covici.com")
	by vger.kernel.org with ESMTP id <S310194AbSCSGSh>;
	Tue, 19 Mar 2002 01:18:37 -0500
To: alsa-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.6 rtc support broke in alsa
From: John Covici <covici@ccs.covici.com>
Date: Tue, 19 Mar 2002 01:18:29 -0500
Message-ID: <m3ofhlf5ca.fsf@ccs.covici.com>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) Emacs/21.1.90
 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  If I try to compile the 2.5.6 kernel with rtc support configured,
I  get an error at line 79 of irqtimer.c complaining that err is
undeclared.

Any assistance would be appreciated.

-- 
         John Covici
         covici@ccs.covici.com
