Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbUDDPmQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 11:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262448AbUDDPmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 11:42:16 -0400
Received: from web41407.mail.yahoo.com ([66.218.93.73]:9911 "HELO
	web41407.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262438AbUDDPmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 11:42:15 -0400
Message-ID: <20040404154214.57585.qmail@web41407.mail.yahoo.com>
Date: Sun, 4 Apr 2004 08:42:14 -0700 (PDT)
From: Parag Nemade <cranium2003@yahoo.com>
Subject: how sk_buff works in sending packet?
To: agulbra <agulbra@nvg.unit.no>, alan <alan.cox@linux.org>,
       aussie <plug@plug.linux.org.au>, becker <becker@super.org>,
       bir7 <bir7@leland.stanford.edu>, goa <ilug-goa@yahoogroups.com>,
       hyd <ilughyd@yahoogroups.com>, jorge <jorge@laser.satlink.net>,
       kernerl mail <linux-kernel@vger.kernel.org>,
       mumbai <mumbai_gnulinux@yahoogroups.com>,
       nashik <nashlug@yahoogroups.com>,
       manish regmi <manish_regmi@hotmail.com>, rk <rklug@yahoogroups.com>,
       vipin sharma <vk.sharma@nhindia.com>, stefan <stefanb@yello.ping.de>,
       linux technical <linux-bangalore-technical@yahoogroups.com>,
       tiruchira <glug_t-request@freelists.org>,
       blug us <blug-list@peakserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,
Where is the data that is to be transmitted from one
machine to another machine is built as a packet in
kernel source?
i want which function in the kernel source does this?
what is the cloned skbuff? 
Parag.

__________________________________
Do you Yahoo!?
Yahoo! Small Business $15K Web Design Giveaway 
http://promotions.yahoo.com/design_giveaway/
