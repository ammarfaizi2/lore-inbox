Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268339AbTGTVHG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 17:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268391AbTGTVHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 17:07:06 -0400
Received: from web13306.mail.yahoo.com ([216.136.175.42]:39295 "HELO
	web13306.mail.yahoo.com") by vger.kernel.org with SMTP
	id S268339AbTGTVHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 17:07:04 -0400
Message-ID: <20030720212205.73683.qmail@web13306.mail.yahoo.com>
Date: Sun, 20 Jul 2003 14:22:05 -0700 (PDT)
From: Ronald Jerome <imun1ty@yahoo.com>
Subject: 2.6.0-test1-mm2 kernel oops in RH 9.0 c840 laptop
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Right after the last INIT:

Starting Freewnn:   [ok]
Starting xfs:       [ok]

Unable to handle kernel NULL pointer dereference at
virtual address 00000014

printing eid:
c0187e19
*pde = 00000000


Oops: 0000 [#1]




But this does  not happen on every boot only
occationally after a fresh boot to 2.6.0-test1-mm2

__________________________________
Do you Yahoo!?
SBC Yahoo! DSL - Now only $29.95 per month!
http://sbc.yahoo.com
