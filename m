Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310607AbSCHADE>; Thu, 7 Mar 2002 19:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310606AbSCHACy>; Thu, 7 Mar 2002 19:02:54 -0500
Received: from web21207.mail.yahoo.com ([216.136.175.165]:33197 "HELO
	web21207.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S310608AbSCHACg>; Thu, 7 Mar 2002 19:02:36 -0500
Message-ID: <20020308000235.24450.qmail@web21207.mail.yahoo.com>
Date: Thu, 7 Mar 2002 16:02:35 -0800 (PST)
From: aryan aru <aryan222is@yahoo.com>
Subject: netlink usage
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I need some help on netlink usage. I have a process
running in user space and a driver in kernel space. I
want to setup a communication between these two
through netlink. From kernel point of view I am not
clear. If I need to send data to user procees thorugh
"netlink_unicast", this method is expecting the
process_id of the process that is running in the user
space. How can I get the process ID from the user
space.

Or is there any other way.

Any help plz...

thanks in advance

regards
seenu

__________________________________________________
Do You Yahoo!?
Try FREE Yahoo! Mail - the world's greatest free email!
http://mail.yahoo.com/
