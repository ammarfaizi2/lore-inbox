Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbUCDGuk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 01:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbUCDGuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 01:50:40 -0500
Received: from komp197.tera.com.pl ([81.21.195.197]:31363 "EHLO wrota.net")
	by vger.kernel.org with ESMTP id S261482AbUCDGuj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 01:50:39 -0500
Date: Thu, 4 Mar 2004 07:50:38 +0100
From: Daniel Fenert <daniel@fenert.net>
To: linux-kernel@vger.kernel.org
Subject: Is there some bug in ext3 in 2.4.25?
Message-ID: <20040304065038.GV31185@fenert.net>
Mail-Followup-To: Daniel Fenert <daniel@fenert.net>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Organization: Co by tu =?iso-8859-2?B?d3Bpc2HmPyBNb78=?=
	=?iso-8859-2?Q?e?= daniellek.z.domu ? ;)
X-Operating-System: Linux 2.4.24
X-Wyslij-mi-SMSa: Lepiej nie...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Message from syslogd@lazy at Thu Mar  4 08:31:58 2004 ...
lazy kernel: Assertion failure in __journal_drop_transaction() at
checkpoint.c:587: "transaction->t_ilist == NULL"

Networking still works, I've tried to login, but no luck here.
I've got one ssh console opened, and tried to reboot, but nothing happend, it
looks like it lost connection with hda :(
Where should I look for reason?
Machine as faaar away, and it's second or third time it hangs mysteriously,
the only difference is that this time I've got some console output.

-- 
Daniel Fenert                 --==> daniel@fenert.net <==--
==-P o w e r e d--b y--S l a c k w a r e-=-ICQ #37739641-==
=======- http://daniel.fenert.net/ -=======< +48604628083 >
