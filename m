Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311391AbSCSP26>; Tue, 19 Mar 2002 10:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311396AbSCSP2s>; Tue, 19 Mar 2002 10:28:48 -0500
Received: from ccs.covici.com ([209.249.181.196]:1924 "EHLO ccs.covici.com")
	by vger.kernel.org with ESMTP id <S311391AbSCSP2p>;
	Tue, 19 Mar 2002 10:28:45 -0500
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: advansys driver doesn't detect tape drive properly in 2.5.6
From: John Covici <covici@ccs.covici.com>
Date: Tue, 19 Mar 2002 10:28:43 -0500
In-Reply-To: <20020307042019.A372@baldur.yggdrasil.com> ("Adam J. Richter"'s
 message of "Thu, 7 Mar 2002 04:20:19 -0800")
Message-ID: <m3eligfufo.fsf@ccs.covici.com>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) Emacs/21.1.90
 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  I have your advansys driver which compiles under 2.5.6, but its
not detecting the tape drive properly, it doesn't give the vendor or
model number and I saw type 18 and 22 and it gives 0 for the ansi
revision.

Any assistance would be appreciated.

-- 
         John Covici
         covici@ccs.covici.com
