Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269505AbUIROIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269505AbUIROIA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 10:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269508AbUIROIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 10:08:00 -0400
Received: from merkurneu.hrz.uni-giessen.de ([134.176.2.3]:7856 "EHLO
	merkurneu.hrz.uni-giessen.de") by vger.kernel.org with ESMTP
	id S269505AbUIROH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 10:07:59 -0400
Date: Sun, 19 Sep 2004 00:07:37 +1000 (EST)
From: Sergei Haller <Sergei.Haller@math.uni-giessen.de>
X-X-Sender: gc1007@fb07-calculator.math.uni-giessen.de
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lost memory on a 4GB amd64
In-Reply-To: <20040916123417.GA68423@muc.de>
Message-Id: <Pine.LNX.4.58.0409190006390.31971@fb07-calculator.math.uni-giessen.de>
References: <2EWxl-7CI-13@gated-at.bofh.it> <m3hdpyy9x3.fsf@averell.firstfloor.org>
 <Pine.LNX.4.58.0409162209450.26494@fb07-calculator.math.uni-giessen.de>
 <20040916123417.GA68423@muc.de>
Organization: University of Giessen * Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-HRZ-JLUG-MailScanner-Information: Passed JLUG virus check
X-HRZ-JLUG-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2004, Andi Kleen (AK) wrote:

AK> On Thu, Sep 16, 2004 at 10:15:22PM +1000, Sergei Haller wrote:
AK> 
AK> > where I describe that there is an option in the BIOS for that but the 
AK> > kernel crashes if I enable it.
AK> 
AK> It means the memory was not correct configured. If you don't trust the kernel
AK> you can use memtest86 to confirm it.

memtest86 is happy with the memory.


c ya
        Sergei
-- 
--------------------------------------------------------------------  -?)
         eMail:       Sergei.Haller@math.uni-giessen.de               /\\
-------------------------------------------------------------------- _\_V
Be careful of reading health books, you might die of a misprint.
                -- Mark Twain
