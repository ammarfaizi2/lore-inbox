Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261401AbREQLrt>; Thu, 17 May 2001 07:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261402AbREQLrj>; Thu, 17 May 2001 07:47:39 -0400
Received: from cvs.zend.com ([194.90.96.36]:39431 "HELO mail.zend.com")
	by vger.kernel.org with SMTP id <S261401AbREQLrf>;
	Thu, 17 May 2001 07:47:35 -0400
Date: Thu, 17 May 2001 14:46:54 +0300 (IDT)
From: Stanislav Malyshev <stas@zend.com>
X-X-Sender: <frodo@shire.zend.office>
To: <linux-kernel@vger.kernel.org>
Subject: gdb/ptrace problem
Message-ID: <Pine.LNX.4.33.0105171443050.4567-100000@shire.zend.office>
Organization: Zend Technologies Ltd (http://www.zend.com/)
X-no-productlinks: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since installing 2.2.19, I have the following problem: each time I try to
attach to a running program with gdb, the result is:

ptrace: Operation not permitted.

and attaching fails. No problem with 2.2.18. Have I missed something? Any
advice on how this can be fixed?

gdb version:
GNU gdb 5.0
Copyright 2000 Free Software Foundation, Inc.

-- 
Stanislav Malyshev, Zend Products Engineer
stas@zend.com  http://www.zend.com/ +972-3-6139665 ext.115



