Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265503AbUEZLpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265503AbUEZLpw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 07:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265506AbUEZLpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 07:45:52 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:60055 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265503AbUEZLp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 07:45:29 -0400
From: "Buddy Lumpkin" <b.lumpkin@comcast.net>
To: "'Denis Vlasenko'" <vda@port.imtp.ilyichevsk.odessa.ua>,
       "'William Lee Irwin III'" <wli@holomorphy.com>
Cc: <orders@nodivisions.com>, <linux-kernel@vger.kernel.org>
Subject: RE: why swap at all?
Date: Wed, 26 May 2004 04:49:09 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <200405261344.36724.vda@port.imtp.ilyichevsk.odessa.ua>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Thread-Index: AcRDDuoj4Vs7N9bsSRSmZJs7XGV3HgACIJNw
Message-Id: <S265503AbUEZLp3/20040526114530Z+465@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have no bug to report.

-----Original Message-----
From: Denis Vlasenko [mailto:vda@port.imtp.ilyichevsk.odessa.ua] 
Sent: Wednesday, May 26, 2004 3:45 AM
To: Buddy Lumpkin; 'William Lee Irwin III'
Cc: orders@nodivisions.com; linux-kernel@vger.kernel.org
Subject: RE: why swap at all?

On Wednesday 26 May 2004 11:30, Buddy Lumpkin wrote:
> As for your short, two sentence comment below, let me save you the energy
> of insinuations and translate your message the way I read it:
> 
> -------------------------------------------------------------------------
> I don't recognize your name, therefore you can't possibly have a valuable
> opinion on the direction VM system development should go. I doubt you have
> an actual performance problem to share, but if you do, please share it and
> go away so that we can work on solving the problem.
> --------------------------------------------------------------------------

He was asking for proper bugreport.

Preparing bug report:
=====================
How To Ask Questions The Smart Way:
    http://www.catb.org/~esr/faqs/smart-questions.html
        Anybody who has written software for public use will
        probably have received at least one bad bug report.
        Reports that say nothing ("It doesn't work!");
        reports that make no sense; reports that don't give
        enough information; reports that give wrong information.
How to Report Bugs Effectively:
    http://www.chiark.greenend.org.uk/~sgtatham/bugs.html
        Before asking a technical question by email, or in
        a newsgroup, or on a website chat board, do the following:
        * Try to find an answer by searching the Web.
        * Try to find an answer by reading the manual.
        * Try to find an answer by reading a FAQ.
        * Try to find an answer by inspection or experimentation.
        * Try to find an answer by reading the source code.
Compile problems: report GCC output and result of
        "grep '^CONFIG_' .config"
Oops: decode it with ksymoops (or use 2.6 with kksymoops enabled ;).
Unkillable process: Alt-SysRq-T and ksymoops relevant part.
Yes it means you should have ksymoops installed and tested,
which is easy to get wrong. I've done that too often.
-- 
vda

