Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262623AbTGAQVm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 12:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbTGAQVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 12:21:42 -0400
Received: from www1.mail.lycos.com ([209.202.220.140]:44888 "HELO lycos.com")
	by vger.kernel.org with SMTP id S262623AbTGAQVl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 12:21:41 -0400
To: linux-kernel@vger.kernel.org
Date: Tue, 01 Jul 2003 12:35:54 -0400
From: "Sumit Narayan" <sumit_uconn@lycos.com>
Message-ID: <ENGCFCDNEADFDEAA@mailcity.com>
Mime-Version: 1.0
X-Sent-Mail: off
Reply-To: sumit_uconn@lycos.com
X-Mailer: MailCity Service
X-Priority: 3
Subject: Thread in Driver
X-Sender-Ip: 137.99.1.12
Organization: Lycos Mail  (http://www.mail.lycos.com:80)
Content-Type: text/plain; charset=us-ascii
Content-Language: en
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I am writing a driver code for IDE Interface, and would like to start a thread in it, which could write to a file at some initialization of proc value. But, when I do this, my kernel hangs. And the file is also not created. Could someone tell the reason for this. Is it coz I have a thread in the IDE Driver?

Thanks in advance.



____________________________________________________________
Get advanced SPAM filtering on Webmail or POP Mail ... Get Lycos Mail!
http://login.mail.lycos.com/r/referral?aid=27005
