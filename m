Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265998AbTGAGF5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 02:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265999AbTGAGF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 02:05:57 -0400
Received: from web20002.mail.yahoo.com ([216.136.225.47]:18852 "HELO
	web20002.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265998AbTGAGFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 02:05:55 -0400
Message-ID: <20030701062017.42244.qmail@web20002.mail.yahoo.com>
Date: Mon, 30 Jun 2003 23:20:17 -0700 (PDT)
From: Raghava Raju <vraghava_raju@yahoo.com>
Subject: To make a function get executed on cpu2
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

In multicpu systems in kernel version 2.4.19, how 
can we specify that a function be executed on 
a cpu of our choice(say cpu_2). Moreover if I call a
function from cpu_1 to be executed on cpu_2, I dont
want to wait in cpu_1 until complete execution of
function on cpu_2 . Is it possible?????

Any example would be really helpful. Please 
mail back to vraghava_raju@yahoo.com.

Regards
Raghava.

__________________________________
Do you Yahoo!?
SBC Yahoo! DSL - Now only $29.95 per month!
http://sbc.yahoo.com
