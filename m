Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262627AbULPHkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262627AbULPHkH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 02:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262629AbULPHkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 02:40:07 -0500
Received: from web53304.mail.yahoo.com ([206.190.39.233]:4214 "HELO
	web53304.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262627AbULPHkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 02:40:04 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=Cus/SQOxmd3mV+ng2my6IDMCa5sUrn1s/XDxEoDJ3v0I+SpJz/XutdtRFLb1PvXwHmlSJfsSVt4njkfIyNMEpYC000G3T3Lk50PUg1Ds3WfjSri+FCY0xkjCfYHEo0GBILGGHOQbd9uaq7DD/Xj7AiEo+9RCLiIy0ggvIHbVix8=  ;
Message-ID: <20041216074004.46385.qmail@web53304.mail.yahoo.com>
Date: Wed, 15 Dec 2004 23:40:04 -0800 (PST)
From: firnnauriel <rinoa012000@yahoo.com>
Subject: bcopy and page faults
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In general, is there a correlation between the number
of page faults occurred in the system and bcopy's
performance? If the page fault is high, will the
bcopy's performance become slower? Kindly enlighten me
on this. If you can provide a URL that will support
your answer, I will really appreciate it. Thank you
very much!

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
