Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262976AbTFOWzV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 18:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbTFOWzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 18:55:21 -0400
Received: from www4.mail.lycos.com ([209.202.220.170]:20000 "HELO lycos.com")
	by vger.kernel.org with SMTP id S262976AbTFOWzT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 18:55:19 -0400
To: sumit_uconn@lycos.com
Date: Sun, 15 Jun 2003 19:09:02 -0400
From: "Sumit Narayan" <sumit_uconn@lycos.com>
Message-ID: <NAOFEAJEJJGBLFAA@mailcity.com>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org
X-Sent-Mail: off
Reply-To: sumit_uconn@lycos.com
X-Mailer: MailCity Service
X-Priority: 3
Subject: Null Pointer Error
X-Sender-Ip: 137.99.1.12
Organization: Lycos Mail  (http://www.mail.lycos.com:80)
Content-Type: text/plain; charset=us-ascii
Content-Language: en
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to write to a function in the kernel which could create a file and add data to it. I am unable to do it, as I am getting Null Pointer Error. I am using threads for this. I dont know if I am going right. Could someone help me with this. How do I write a function in the kernel which could create a file, and write data to it. Somehow, sys_open and sys_read are not working. I think I am doing some mistake somewhere. Please help me. Thanks in advance.

Sumit


____________________________________________________________
Get advanced SPAM filtering on Webmail or POP Mail ... Get Lycos Mail!
http://login.mail.lycos.com/r/referral?aid=27005
