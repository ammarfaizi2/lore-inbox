Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265061AbTGBPrD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 11:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265063AbTGBPrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 11:47:03 -0400
Received: from www1.mail.lycos.com ([209.202.220.140]:52316 "HELO lycos.com")
	by vger.kernel.org with SMTP id S265061AbTGBPrB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 11:47:01 -0400
To: linux-kernel@vger.kernel.org
Date: Wed, 02 Jul 2003 12:01:21 -0400
From: "Sumit Narayan" <sumit_uconn@lycos.com>
Message-ID: <BIALEOFCFLPJDEAA@mailcity.com>
Mime-Version: 1.0
X-Sent-Mail: off
Reply-To: sumit_uconn@lycos.com
X-Mailer: MailCity Service
X-Priority: 3
Subject: [IDE Driver] kernel hands with thread
X-Sender-Ip: 137.99.1.12
Organization: Lycos Mail  (http://www.mail.lycos.com:80)
Content-Type: text/plain; charset=us-ascii
Content-Language: en
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am initiating a thread in the IDE Disk Driver to write to a file after a check on a proc value. It is not enables until the kernel boots completly. The kernel works fine, and once I enable this file write process, the kernel hangs. Could I know the reason. Does having the thread from the driver makes a difference?

Thanks in advance

Sumit


____________________________________________________________
Get advanced SPAM filtering on Webmail or POP Mail ... Get Lycos Mail!
http://login.mail.lycos.com/r/referral?aid=27005
