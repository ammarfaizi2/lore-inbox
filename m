Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbVAJFEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbVAJFEw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 00:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVAJFEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 00:04:52 -0500
Received: from web60608.mail.yahoo.com ([216.109.119.82]:49539 "HELO
	web60608.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262085AbVAJFEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 00:04:50 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=CcP4HRSdv5NuF9aBXOP8UnTbYnDzJC2ZHF1oCuLTAMIFmzAFLEqZjVyO0nOCTviqoLBEk0jrThK2HodQhVJjRApeVWFD231/XTgllrqkOMxtqRw+ZNQFxG4sRialh8WEuCPsNVEzjH+VcTBYAJ87SN4ZIEStW4itbz00E1b/27E=  ;
Message-ID: <20050110050450.51158.qmail@web60608.mail.yahoo.com>
Date: Sun, 9 Jan 2005 21:04:50 -0800 (PST)
From: selvakumar nagendran <kernelselva@yahoo.com>
Subject: Pipefs : doubts
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello linux-experts,
    I went through the kernel source code file
/fs/pipe.c and I found that the pipe file system
configured as a module. But in lsmod I am unable to
see it. This is my first doubt.
    My second doubt is, in pipe.c we have lot of
symbols like 

  PIPE_WAITING_READERS(*inode)
  PIPE_WAIT(*inode)
  PIPE_MAX_RCHUNK(*inode)
   What are they? funtions or macros? What they do or
where are their implementation in the kernel source
tree?
 
Thanks,
selva


		
__________________________________ 
Do you Yahoo!? 
The all-new My Yahoo! - Get yours free! 
http://my.yahoo.com 
 

