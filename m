Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261466AbTCGCbf>; Thu, 6 Mar 2003 21:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261481AbTCGCbf>; Thu, 6 Mar 2003 21:31:35 -0500
Received: from sccrmhc02.attbi.com ([204.127.202.62]:13038 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S261466AbTCGCbe>; Thu, 6 Mar 2003 21:31:34 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Eric Altendorf <EricAltendorf@orst.edu>
Reply-To: EricAltendorf@orst.edu
To: swsusp@lister.fornax.hu, linux-kernel@vger.kernel.org
Subject: 2.5.63: ACPI S3 and S4 suspend problems
Date: Thu, 6 Mar 2003 11:48:15 -0800
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200303061148.15685.EricAltendorf@orst.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all, running a Libretto L2 (ACPI only) on which I've been trying to 
get suspend working for ages.  My latest try was 2.5.63 with the 
20030228 ACPI update patch.

S3 powers down into sleep mode, and upon awakening, prints
        Linux!
in yellow text and hangs.

S4 starts putting processes in the refrigerator, and hangs on the last 
line (which just says "=|" IIRC).

Any ideas?  I can supply system info and kernel config info if 
helpful.

Thanks,
eric
-- 
"First they ignore you.  Then they laugh at you.
 Then they fight you.  And then you win."             -Gandhi


