Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261887AbUDXDrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbUDXDrJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 23:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbUDXDrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 23:47:09 -0400
Received: from mail.tpgi.com.au ([203.12.160.100]:39092 "EHLO
	mail5.tpgi.com.au") by vger.kernel.org with ESMTP id S261887AbUDXDrH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 23:47:07 -0400
Date: Sat, 24 Apr 2004 13:27:37 +1000
From: "Nigel Cunningham" <ncunningham@linuxmail.com>
To: "Grzegorz Piotr Jaskiewicz" <gj@pointblue.com.pl>,
       "Pavel Machek" <pavel@ucw.cz>
Subject: Re: swsusp: fix error handling in "not enough swap space"
Cc: "kernel list" <linux-kernel@vger.kernel.org>
Reply-To: ncunningham@linuxmail.com
References: <4089DC36.5020806@pointblue.com.pl>
Content-Type: text/plain; format=flowed; delsp=yes; charset=us-ascii
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <opr6xykbzqruvnp2@laptop-linux.wpcb.org.au>
In-Reply-To: <4089DC36.5020806@pointblue.com.pl>
User-Agent: Opera M2/7.50 (Linux, build 663)
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Can we assume you've tried running mkswap again? Could you also show  
/proc/meminfo prior to suspending?

Regards,

Nigel

-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614, Australia.
+61 (2) 6251 7727 (wk)
