Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263700AbTLDXO6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 18:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263702AbTLDXO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 18:14:58 -0500
Received: from may.nosdns.com ([207.44.240.96]:48026 "EHLO may.nosdns.com")
	by vger.kernel.org with ESMTP id S263700AbTLDXOz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 18:14:55 -0500
Date: Thu, 4 Dec 2003 16:14:41 -0700
From: "Russell \"Elik\" Rademacher" <elik@webspires.com>
X-Mailer: The Bat! (v2.00.6) Business
Reply-To: "Rusell \"Elik\" Rademacher" <elik@webspires.com>
X-Priority: 3 (Normal)
Message-ID: <18715758953.20031204161441@webspires.com>
To: linux-kernel@vger.kernel.org
Subject: Hyperthreading - Found the answers
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - may.nosdns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - webspires.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello linux-kernel,

  Thanks folks.  Apparently, the documentations are little buried under but apparently, needed to have boot time parameter as follows:  acpismp=force to have the hyperthreading to show up properly.

-- 
Best regards,
Russell "Elik" Rademacher
Freelance Remote System Adminstrator/Tech Support    

