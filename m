Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264085AbUHBXfI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264085AbUHBXfI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 19:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264297AbUHBXfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 19:35:08 -0400
Received: from web50903.mail.yahoo.com ([206.190.38.123]:47511 "HELO
	web50903.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264085AbUHBXfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 19:35:04 -0400
Message-ID: <20040802233503.49599.qmail@web50903.mail.yahoo.com>
Date: Mon, 2 Aug 2004 16:35:03 -0700 (PDT)
From: sankarshana rao <san_wipro@yahoo.com>
Subject: reiserfs_create: no enough blocks on device
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am trying to create a reiserfs filesystem using the
command 
'mkreiserfs  /dev/loop/0 5000'.
It always gives me the error 
"reiserfs_create: no enough blocks on device".

I tried altering the block size, but it would not
help..
Pls help with any tips...

thx in advance
Sankarshana M



		
__________________________________
Do you Yahoo!?
Yahoo! Mail - 50x more storage than other providers!
http://promotions.yahoo.com/new_mail
