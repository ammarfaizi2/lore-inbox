Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274820AbTGaQan (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 12:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274821AbTGaQan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 12:30:43 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:52423 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S274820AbTGaQal
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 12:30:41 -0400
Message-ID: <3F294461.2020902@softhome.net>
Date: Thu, 31 Jul 2003 18:31:29 +0200
From: "Ihar \"Philips\" Filipau" <filia@softhome.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.6 size increase
References: <cArb.74D.1@gated-at.bofh.it> <cUTh.6JZ.33@gated-at.bofh.it> <eLiy.31J.3@gated-at.bofh.it> <eLBW.3eJ.7@gated-at.bofh.it> <eLVb.3yF.1@gated-at.bofh.it> <eOJn.5NI.1@gated-at.bofh.it> <f1dJ.GS.21@gated-at.bofh.it> <faTE.2LQ.3@gated-at.bofh.it> <fd56.4Te.9@gated-at.bofh.it> <fdRv.5uB.9@gated-at.bofh.it> <fnHd.54o.19@gated-at.bofh.it>
In-Reply-To: <fnHd.54o.19@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> 
> Power Management, sysfs plays / will play a role in finding out the order
> in which devices get powered down.  This is important on some types of
> embedded devices (and arguably important everywhere).
> 

   You are contradicting to yourself.

   I have participated in creation of two specialized embedded systems, 
and currently going into third one.
   Every system were need some specialized shutdown sequence.
   None of them were need power saving.

   Please do not generalize your particular system to everything else.

   No one needs another self-aware self-configurable software subsystem, 
which intended to do the task of the engineers. Especially when this 
task takes 15 minutes to code.

