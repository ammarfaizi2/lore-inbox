Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261795AbVC3HWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbVC3HWi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 02:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbVC3HWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 02:22:35 -0500
Received: from web52209.mail.yahoo.com ([206.190.39.91]:53611 "HELO
	web52209.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261795AbVC3HWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 02:22:23 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=3hqUeF3reXBvi5si+4uxC7Tk+HDCzOpS2r69djWzaPS0RZ/7MPJugVE/V9aeIpYtklOYxPxzGMG3dMbMZssllsFLauv+Q+biWRz9gQUMl+9RLV1yXakeetCU/h3LPkxfUnnLwfaeJPUatnJXos4PKK7QRJ+svHsaB9wjJyizI94=  ;
Message-ID: <20050330072221.70921.qmail@web52209.mail.yahoo.com>
Date: Tue, 29 Mar 2005 23:22:21 -0800 (PST)
From: linux lover <linux_lover2004@yahoo.com>
Subject: Re: Accessing data structure from kernel space
To: linux-kernel@vger.kernel.org
Cc: jengelh@linux01.gwdg.de, linux-os@analogic.com, pj@engr.sgi.com
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello sir,
          
       I successfully added linked list data structure
  in kernel in header file. Write a C source file and
add it to kernel directory. then write 2 system calls
that read and write to linked list from user space
through that syscalls. 
       recompile kernel. Now able to read/write that
linked list.
       I want to write user data in that linked list
and allow kernel to use that info in linked list. Is
my approach to send data from user to kernel  and
store there as long as OS is not rebooted is right?
 Please reply me.
Thanks in advance.
regards,
linux_lover.  
           



		
__________________________________ 
Do you Yahoo!? 
Yahoo! Small Business - Try our new resources site!
http://smallbusiness.yahoo.com/resources/ 
