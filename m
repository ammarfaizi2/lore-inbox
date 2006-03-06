Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbWCFFfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbWCFFfK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 00:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWCFFfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 00:35:10 -0500
Received: from supmuscle.dreamhost.com ([66.33.192.105]:27278 "EHLO
	coverity.dreamhost.com") by vger.kernel.org with ESMTP
	id S1751246AbWCFFfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 00:35:09 -0500
Message-ID: <440BCA0F.50501@coverity.com>
Date: Sun, 05 Mar 2006 21:35:11 -0800
From: Ben Chelf <ben@coverity.com>
Reply-To: ben@coverity.com
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Coverity Open Source Defect Scan of Linux
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linux Developers,

   I'm the CTO of Coverity, Inc., a company that does static source code 
analysis to look for defects in code. You may have heard of us or of our 
technology from its days at Stanford (the "Stanford Checker"). The 
reason I'm writing is because we have set up a framework internally to 
continually scan open source projects and provide the results of our 
analysis back to the developers of those projects. Linux is one of the 
32 projects currently scanned at:

http://scan.coverity.com

   My belief is that we (Coverity) must reach out to the developers of 
these packages (you) in order to make progress in actually fixing the 
defects that we happen to find, so this is my first step in that 
mission. Of course, I think Coverity technology is great, but I want to 
hear what you think and that's why I worked with folks at Coverity to 
put this infrastructure in place. The process is simple -- it checks out 
your code each night from your repository and scans it so you can always 
see the latest results.

   Right now, we're guarding access to the actual defects that we report 
for a couple of reasons: (1) We think that you, as developers of Linux, 
should have the chance to look at the defects we find to patch them 
before random other folks get to see what we found and (2) From a 
support perspective, we want to make sure that we have the appropriate 
time to engage with those who want to use the results to fix the code. 
Because of this second point, I'd ask that if you are interested in 
really digging into the results a bit further for your project, please 
have a couple of core maintainers (or group nominated individuals) reach 
out to me to request access. As this is a new process for us and still 
involves a small number of packages, I want to make sure that I 
personally can be involved with the activity that is generated from this 
effort.

   So I'm basically asking for people who want to play around with some 
cool new technology to help make source code better. If this interests 
you, please feel free to reach out to me directly. And of course, if 
there are other packages you care about that aren't currently on the 
list, I want to know about those too.

   If this is the wrong list, my sincerest apologies and please let me 
know where would be a more appropriate forum for this type of message.

Many thanks for reading this far...

-ben

  Ben Chelf
  Chief Technology Officer
  Coverity, Inc.
