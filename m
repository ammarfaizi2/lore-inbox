Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264366AbUBHUnG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 15:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264364AbUBHUnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 15:43:05 -0500
Received: from may.nosdns.com ([207.44.240.96]:40872 "EHLO may.nosdns.com")
	by vger.kernel.org with ESMTP id S264366AbUBHUnD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 15:43:03 -0500
Date: Sun, 8 Feb 2004 13:43:58 -0700
From: Elikster <elik@webspires.com>
X-Mailer: The Bat! (v2.02.3 CE) Personal
Reply-To: Elikster <elik@webspires.com>
Organization: WebSpires Technologies
X-Priority: 3 (Normal)
Message-ID: <1874282993.20040208134358@webspires.com>
To: linux-kernel@vger.kernel.org
Subject: Processor Selection List
In-Reply-To: <S264363AbUBHUIT/20040208200819Z+74@vger.kernel.org>
References: <S264363AbUBHUIT/20040208200819Z+74@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - may.nosdns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - webspires.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings folks,

   Would it be possible to make a slight change in the listing of the processors selection, especially the Celerons?  It seems it is sort of difficult to tell which Celeron goes into which catagory, when they are using same naming for 3 generations.

   Of interest is the P4 Celerons, which seems to have started at 1.8 GHz.  Would it be possible if we amend it to add this line as this:

Original: "Pentium-4" for the Intel Pentium 4 or P4-based Celeron.
Revised: "Pentium-4" for the Intel Pentium 4 or P4-based 1.8 Celeron or later

   It would help stop the little confusion as I have found out when I compiled the 2.6.2 on Celeron 1.7 and it seems to crash one way or other when I selected the Pentium-4 for compile and after recompiling it to Pentium III, it works fine.

   Not sure on the Pre-Coppermine Celeron, but I do know that there is some confusion on trying to figure out which version of Celeron by looking at the clock speed itself for Coppermine and P4 versions.

-- 
Best regards,
 Elikster                            mailto:elik@webspires.com

