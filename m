Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261592AbVBOCAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbVBOCAU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 21:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbVBOCAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 21:00:20 -0500
Received: from web50201.mail.yahoo.com ([206.190.38.42]:39050 "HELO
	web50201.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261592AbVBOCAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 21:00:16 -0500
Message-ID: <20050215020011.39543.qmail@web50201.mail.yahoo.com>
Date: Mon, 14 Feb 2005 18:00:11 -0800 (PST)
From: Alex Davis <alex14641@yahoo.com>
Subject: Re: Pty is losing bytes
To: linux-kernel@vger.kernel.org
Cc: schwab@suse.de
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem does not exist on 2.6.8.1. Compiling your program and running

./a.out < README | diff README -

produces no output.

I tested various files ranging in size from 10 to 60k.

-Alex


=====
I code, therefore I am


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - 250MB free storage. Do more. Manage less. 
http://info.mail.yahoo.com/mail_250
