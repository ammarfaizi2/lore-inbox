Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265007AbTF1Bc4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 21:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265012AbTF1Bc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 21:32:56 -0400
Received: from web40602.mail.yahoo.com ([66.218.78.139]:63748 "HELO
	web40602.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265007AbTF1Bcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 21:32:55 -0400
Message-ID: <20030628014710.32726.qmail@web40602.mail.yahoo.com>
Date: Fri, 27 Jun 2003 18:47:10 -0700 (PDT)
From: Miles T Lane <miles_lane@yahoo.com>
Subject: 2.5.73-bk5 -- intermezzo.ko needs unknown symbol set_fs_root, vga16fb.ko needs unknown symbol screen_info
To: linux-kernel@vger.kernel.org, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Ben Pfaff <pfaffben@debian.org>, "Peter J. Braam" <braam@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

if [ -r System.map ]; then /sbin/depmod -ae -F
System.map  2.5.73-bk5; fi
WARNING:
/lib/modules/2.5.73-bk5/kernel/fs/intermezzo/intermezzo.ko
needs unknown symbol set_fs_root
WARNING:
/lib/modules/2.5.73-bk5/kernel/fs/intermezzo/intermezzo.ko
needs unknown symbol set_fs_pwd
WARNING:
/lib/modules/2.5.73-bk5/kernel/drivers/video/vga16fb.ko
needs unknown symbol screen_info


__________________________________
Do you Yahoo!?
SBC Yahoo! DSL - Now only $29.95 per month!
http://sbc.yahoo.com
