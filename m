Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbTI3UcA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 16:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbTI3UcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 16:32:00 -0400
Received: from lvs00-fl-n03.valueweb.net ([216.219.253.136]:3296 "EHLO
	ams003.ftl.affinity.com") by vger.kernel.org with ESMTP
	id S261712AbTI3Ub6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 16:31:58 -0400
Message-ID: <3F79E7EE.80808@coyotegulch.com>
Date: Tue, 30 Sep 2003 16:30:38 -0400
From: Scott Robert Ladd <coyote@coyotegulch.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030908 Debian/1.4-4
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test6 -- Huh???
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I freely admit to being something of a neophyte when it comes to the 
internal details of the Linux kernel. I've been successfully running 
development and test kernels since 2.5.40 or so, and I've never before 
seen anything like the following:

   Message from syslogd@Tycho at Tue Sep 30 16:09:01 2003 ...
   Tycho vmunix: ris/b/la/up.us0:rr - rdi ptests

   Message from syslogd@Tycho at Tue Sep 30 16:09:01 2003 ...
   Tycho vmunix: dreruscls/blc:bl: ro-1eangriertas

   Message from syslogd@Tycho at Tue Sep 30 16:09:01 2003 ...
   Tycho vmunix: ris//cs/lp: lper -rengin sus>dersbasus.csb: or9
       diprerat<3iv/u/cs/lp up0rr-1eag ntsts

   Message from syslogd@Tycho at Tue Sep 30 16:09:01 2003 ...
   Tycho vmunix: ris//cs/lp up0rr -rengin sus>dersbassbc:bl: or9
       diprerat<3iv/ucl/up. up0rr-1eag ntsts

The above messages appeared in a root terminal running from Gnome, while 
I was outside replacing fuses in my truck. Given that my truck is not 
yet running Linux or connected to my network (give me time...), I'm at a 
loss as to what caused the above, and what it means.

Polite illumination will be most graciously appreciated.

-- 
Scott Robert Ladd
Coyote Gulch Productions (http://www.coyotegulch.com)
Software Invention for High-Performance Computing

