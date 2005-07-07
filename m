Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbVGGUO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbVGGUO0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 16:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbVGGUMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 16:12:45 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:51349 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S262401AbVGGUG3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 16:06:29 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Ingo Molnar <mingo@elte.hu>
Subject: 2.6.12-RT-V0.7.51-12 and x86-64
Date: Thu, 7 Jul 2005 21:06:31 +0100
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507072106.31970.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Latest patch doesn't compile on non-i386 arches. I found all users of INIT_FS; 
need to be audited to INIT_FS(init_fs); like i386; then it compiles fine.

Ingo, could you also respond to my other thread, I uploaded the screenshot you 
requested.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
