Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262294AbTEFDD0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 23:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262300AbTEFDDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 23:03:09 -0400
Received: from www1.mail.lycos.com ([209.202.220.140]:13781 "HELO lycos.com")
	by vger.kernel.org with SMTP id S262294AbTEFDCg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 23:02:36 -0400
To: linux-kernel@vger.kernel.org
Date: Mon, 05 May 2003 23:14:46 -0400
From: "Sumit Narayan" <sumit_uconn@lycos.com>
Message-ID: <FCLJBBJOHCHPBDAA@mailcity.com>
Mime-Version: 1.0
X-Sent-Mail: off
Reply-To: sumit_uconn@lycos.com
X-Mailer: MailCity Service
X-Priority: 3
Subject: Write file in EXT2
X-Sender-Ip: 137.99.1.12
Organization: Lycos Mail  (http://www.mail.lycos.com:80)
Content-Type: text/plain; charset=us-ascii
Content-Language: en
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I would like to create a log file containing the reads and writes made on a disk, by adding a function in the kernel. And once this log table reaches a limit, say 10,000 records, I would like it to be written on hard disk automatically. I am unable to do this, since I dont know how to write to a file, while in the kernel. I tried System Calls, but they dont seem to work. Could someone tell me what is the list of functions that I need to use to do this job. I think I have to play with super-blocks and inodes. But I dont know how to do that. :) Please help me.
Thanks.
Sumit

p.s. I am using Kernel 2.4.20 and want this in EXT2 FS


____________________________________________________________
Get advanced SPAM filtering on Webmail or POP Mail ... Get Lycos Mail!
http://login.mail.lycos.com/r/referral?aid=27005
