Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262032AbSJDWjO>; Fri, 4 Oct 2002 18:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262036AbSJDWjO>; Fri, 4 Oct 2002 18:39:14 -0400
Received: from web40001.mail.yahoo.com ([66.218.78.19]:55184 "HELO
	web40001.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S262032AbSJDWjN>; Fri, 4 Oct 2002 18:39:13 -0400
Message-ID: <20021004224442.80717.qmail@web40001.mail.yahoo.com>
Date: Fri, 4 Oct 2002 15:44:42 -0700 (PDT)
From: Venkat Raghu <venkatraghu2002@yahoo.com>
Subject: newbie
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a basic question. When some function calls
panic:
1)Can I store some registers into nonvolatile 
memory. I will call this function from the very
beginning of my panic function.

2) What exactly happens when a function calls panic
.i.e. a)what all things are inaccessible, in my 
case I will be embedding my code at the very beginning
of panic function, so what things will be inaccessible
to my code b) what is control flow after a function
calls panic.

Any help will really useful. Kindly mail to
venkatraghu2002@yahoo.com, as I did't subscribe.

Regards
Venkat.

__________________________________________________
Do you Yahoo!?
New DSL Internet Access from SBC & Yahoo!
http://sbc.yahoo.com
