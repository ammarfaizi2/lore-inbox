Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275219AbTHAOh3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 10:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275119AbTHAOh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 10:37:29 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:13331 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S275219AbTHAOhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 10:37:18 -0400
Message-ID: <3F2A7DCA.30607@techsource.com>
Date: Fri, 01 Aug 2003 10:48:42 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Mouse sensitivity setting a kernel driver issue?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been having trouble with my RedHat 9 installation where I can't 
seem to be able to set mouse sensitivity and acceleration properly.  The 
controls in the appropriate "preferences" applet do not have the desired 
effect.  Doing some research has suggested to me that this may be an 
issue with the PS/2 mouse kernel driver which may make it relevant to 
this list.

I'm using whatever kernel is the latest thing from RedHat's up2date, 
which is some 2.4.20 kernel.

I'm not sure what system info should be posted in this case which would 
apply, so please ask.  If this is not a kernel issue, then I apologize 
in advance.


Thank you.





I posted this to two newsgroups, but I haven't gotten any responses yet:


Subject: HELP: Cannot set mouse sensitivity under Red Hat 9

The relevant parts of my system are this:

- RedHat 9
- Logitech PS/2 optical mouse
- Abit KD7 motherboard (KT400)

Using RedHat's system configuration tools, I go to Preferences >
Mouse, and I adjust the mouse sensitivity and acceleration.  Neither
has any effect on the mouse movement.

I noticed that if I go to System Settings > Mouse, run the tool, then
quit, the acceleration is adjusted, but there is no effect on the
sensitivity.

I can set the sensitivity to anything I want, but it has no effect.
If I log out and back in, whatever I'd set before is reset to default.

Is there something I can do to fix this?


Thanks.

