Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265455AbUEZKvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265455AbUEZKvP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 06:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265460AbUEZKvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 06:51:15 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:6151 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S265455AbUEZKvN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 06:51:13 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: "Buddy Lumpkin" <b.lumpkin@comcast.net>,
       "'William Lee Irwin III'" <wli@holomorphy.com>
Subject: RE: why swap at all?
Date: Wed, 26 May 2004 13:44:36 +0300
X-Mailer: KMail [version 1.4]
Cc: <orders@nodivisions.com>, <linux-kernel@vger.kernel.org>
References: <S265353AbUEZI1M/20040526082712Z+1294@vger.kernel.org>
In-Reply-To: <S265353AbUEZI1M/20040526082712Z+1294@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200405261344.36724.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
