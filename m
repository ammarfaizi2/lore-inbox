Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270239AbTGRMzn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 08:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270240AbTGRMzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 08:55:43 -0400
Received: from anchor-post-39.mail.demon.net ([194.217.242.80]:15759 "EHLO
	anchor-post-39.mail.demon.net") by vger.kernel.org with ESMTP
	id S270239AbTGRMzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 08:55:39 -0400
Message-ID: <3F17F1CC.1000903@superbug.demon.co.uk>
Date: Fri, 18 Jul 2003 14:10:36 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: I have an oops report for a usb problem. Is this the correct list
 to post it to?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have an oops report for a usb problem. Is this the correct list to 
post it to.
I want to post the ksymoops decoded opps, together with a copy of the 
module's source code in which the oops happened, together with the 
module.o file, thinking that with all that, it should help the developer 
of that module cure the problem.
The source file where the oops happens is 
./linux-2.4.21/drivers/usb/host/uhci.c

I cannot see any kernel mailing list dedicated to usb, so that is why I 
am asking before posting what might be a largish post of linux-kernel.

Cheers
James

