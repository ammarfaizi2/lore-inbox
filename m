Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262498AbVAKIOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262498AbVAKIOm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 03:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262505AbVAKIOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 03:14:42 -0500
Received: from web60606.mail.yahoo.com ([216.109.118.244]:27576 "HELO
	web60606.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262498AbVAKIOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 03:14:41 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=pUTNkyML4v2INJCLNacra2DstQ7cPtEuPtkQ0zyrQ00GM27/dt5mC0vTfdeVALsY2KvCcLL9ew9dH7V5XXu18a32HRntCh3xMiVa6pPJH546YqSVTTjC8S4zeYYwJobDet/YwRz7P07VXag8K5Rv4WDyDBPtt4Kk0UPI/P/OnhE=  ;
Message-ID: <20050111081440.19640.qmail@web60606.mail.yahoo.com>
Date: Tue, 11 Jan 2005 00:14:40 -0800 (PST)
From: selvakumar nagendran <kernelselva@yahoo.com>
Subject: Module unloading doubt
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello linux-experts,
  I have a small doubt as far as kernel modules are
concerned. If we are inserting a module using insmod
and if we are rebooting the system, will the module be
removed in the usual way? i.e. Will the effect be the
same as that of 'rmmod module'?

Thanks,
selva


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Helps protect you from nasty viruses. 
http://promotions.yahoo.com/new_mail
