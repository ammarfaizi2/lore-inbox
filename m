Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262325AbVAJQrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262325AbVAJQrJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 11:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbVAJQrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 11:47:08 -0500
Received: from lakermmtao05.cox.net ([68.230.240.34]:49038 "EHLO
	lakermmtao05.cox.net") by vger.kernel.org with ESMTP
	id S262325AbVAJQq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 11:46:59 -0500
Message-ID: <41E2B181.3060009@rueb.com>
Date: Mon, 10 Jan 2005 10:46:57 -0600
From: Steve Bergman <steve@rueb.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Proper procedure for reporting possible security vulnerabilities?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There seems to be some confusion in certain quarters as to the proper 
procedure for reporting possible kernel security issues.   
REPORTING-BUGS says send bug reports to the maintainer of that area of 
the kernel.  However, what about areas for which a maintainer is not 
listed?  (e.g. VM)  It seems that some take that to mean send it 
directly to Linus and if you don't hear something back quickly, release 
an exploit to the wild.

So what is the preferred procedure and is it documented somewhere?  
Should it be made more prominent?

Thanks for any information,
Steve Bergman
