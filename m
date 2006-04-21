Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbWDULtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbWDULtP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 07:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbWDULtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 07:49:15 -0400
Received: from mailbigip.dreamhost.com ([208.97.132.5]:40848 "EHLO
	randymail-a10.dreamhost.com") by vger.kernel.org with ESMTP
	id S1751280AbWDULtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 07:49:15 -0400
From: steve szmidt <steve@szmidt.org>
To: linux-kernel@vger.kernel.org
Subject: Potential kernel lockup
Date: Fri, 21 Apr 2006 07:49:06 -0400
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604210749.06295.steve@szmidt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I thought it might be of value to know that I got what looks like a kernel 
lockup that instantly froze the system (incl mouse) and any network access, 
requiring a hard reset to recover.

Using 2.6.16-1.2096_FC5, AMD 2700+ and KDE (all updated as of 4/20) 1.5G RAM 
and nVidia 4200 with binary only nVidia driver under Xinerama.

Since the kernel really should not be able to be crashed like this someone 
here might be interested in tracking it, if nothing else to build up a number 
of common denominators.

If this is of value I can be contacted off list for all the details.

-- 

Steve Szmidt

"For evil to triumph all that is needed is for good men to do nothing.
						Edmund Burke
