Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbVCDGRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbVCDGRI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 01:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbVCDGRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 01:17:08 -0500
Received: from smtp806.mail.sc5.yahoo.com ([66.163.168.185]:43666 "HELO
	smtp806.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261520AbVCDGRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 01:17:03 -0500
From: Russell Miller <rmiller@duskglow.com>
To: linux-kernel@vger.kernel.org
Subject: auditing subsystem
Date: Thu, 3 Mar 2005 22:18:11 -0800
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503032218.12062.rmiller@duskglow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been doing a lot of research on this, and I keep coming up with things 
that don't work, have been abandoned, or are almost impossible to find or get 
working.  So I'll ask here.  Maybe one of the ultra-elightened linux gods 
will have a ready answer.

I want to be able to audit system calls - I want to log when files are opened, 
created, changed, deleted, etc.  Preferably I would like to do it without 
having to apply kernel patches, using vanilla (or close to vanilla) kernel.  
If this isn't possible, my net preference is to use a module.  If this isn't 
possible, well, I'll do what I have to.

I notice there is a CONFIG_AUDIT option.  Is this what I am looking for, and 
how do I use it?  /dev/audit seems not to work...

Thanks.  If you can even point me a suitable FM to R, I'd be content.

--Russell

-- 

Russell Miller - rmiller@duskglow.com - Agoura, CA
