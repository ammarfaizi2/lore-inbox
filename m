Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317889AbSGZR45>; Fri, 26 Jul 2002 13:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317891AbSGZR45>; Fri, 26 Jul 2002 13:56:57 -0400
Received: from linux1.deming-os.org ([63.229.178.1]:14858 "EHLO deming-os.org")
	by vger.kernel.org with ESMTP id <S317889AbSGZR45>;
	Fri, 26 Jul 2002 13:56:57 -0400
Message-ID: <3D418DFD.8000007@deming-os.org>
Date: Fri, 26 Jul 2002 10:59:25 -0700
From: Russell Lewis <spamhole-2001-07-16@deming-os.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Looking for links: Why Linux Doesn't Page Kernel Memory?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have spent some time working on AIX, which pages its kernel memory. 
 It pins the interrupt handler functions, and any data that they access, 
but does not pin the other code.

I'm looking for links as to why (unless I'm mistaken) Linux doesn't do 
this, so I can better understand the system.

Thanks, and sorry for the broadcast message.  My web search turned up 
nothing.

Russ Lewis

