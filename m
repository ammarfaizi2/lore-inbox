Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264443AbUHJL6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264443AbUHJL6H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 07:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbUHJL6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 07:58:07 -0400
Received: from relay2.mail.uk.clara.net ([80.168.70.142]:24588 "EHLO
	relay2.mail.uk.clara.net") by vger.kernel.org with ESMTP
	id S264443AbUHJL6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 07:58:04 -0400
Message-ID: <4118B849.9070202@unihost.net>
Date: Tue, 10 Aug 2004 12:58:01 +0100
From: "Tony (Unihost)" <tony@unihost.net>
Organization: Unihost Ltd.
User-Agent: Mozilla Thunderbird 0.7.3 (Macintosh/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: APIC Error 04(04) Kernel Breakage
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been referred to the LKML by a few different people regarding this 
problem so here goes.  I've googled for the problem and can find other 
people with similar problems but as yet can find no one that has 
resolved the issue.

An example is here: 
http://www.ussg.iu.edu/hypermail/linux/kernel/0201.2/1308.html//

The Mobo in question is an Asus A7M266-D, currently running the latest 
BIOS and a pair of MP1600 Procs.  All is functioning well (apart from 
crashes from the AACRAID driver)  I'm runnning Kernel 2.6.3.   It is a 
production server which makes debugging all the more difficult.

When the server was taken down a week or two ago for an upgrade, two AMD 
MP2800 processors were installed.  Upon reboot there was a flood of /

"APIC error on CPU0: 04(04)"

/
The server remains like this until power cycled.  When the original 
MP1600 procs are installed again it all runs fine. I've seen various 
explainations from "Asus won't divulge any info to Linux Developers" to 
"Just turn off APIC".  So I'm out of ideas and people to ask.  Can 
anyone help me solve this issue?

Regards

Tony

//

