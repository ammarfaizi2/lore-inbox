Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262240AbVBVHiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbVBVHiQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 02:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbVBVHiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 02:38:16 -0500
Received: from web52210.mail.yahoo.com ([206.190.39.92]:46942 "HELO
	web52210.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262240AbVBVHiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 02:38:09 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=Pdh7w6pzeR2Bny409b75aRjgLlk9t6aV25em383rNty7D5kZwh/rGbQJnQl26NGf5h17WYcQ4vZm7vybXmLwAEdj28AExaCLk2N1rrS0CR8VkAZjYWxn+ayM9PP7N3WiqSWXO9/ihNyoB0DcZf1golr5hdUlK6jlwJ8mw9PXFo8=  ;
Message-ID: <20050222073808.2221.qmail@web52210.mail.yahoo.com>
Date: Mon, 21 Feb 2005 23:38:08 -0800 (PST)
From: linux lover <linux_lover2004@yahoo.com>
Subject: Which types of functions are exported by kernel source?
To: linux-kernel@vger.kernel.org, lkg india <lkg_india@yahoogroups.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
     While browsing linux source code what i found
that if function is defined as 
asmlinkage long sys_open(const char * filename, int
flags, int mode)
then its not exported to kenrel and thus not seen in
/proc/ksyms. But if function in kernel source is not
defined with asmlinkage then it is exported to kernel
and seen in /proc/ksyms.
      Is that correct??
regards,
linux_lover.


		
__________________________________ 
Do you Yahoo!? 
All your favorites on one personal page – Try My Yahoo!
http://my.yahoo.com 
