Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVABMHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVABMHz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 07:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVABMHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 07:07:55 -0500
Received: from smtp.uninet.ee ([194.204.0.4]:61714 "EHLO smtp.uninet.ee")
	by vger.kernel.org with ESMTP id S261189AbVABMHm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 07:07:42 -0500
Message-ID: <41D7E3EF.8000700@tuleriit.ee>
Date: Sun, 02 Jan 2005 14:07:11 +0200
From: Indrek Kruusa <indrek.kruusa@tuleriit.ee>
Reply-To: indrek.kruusa@tuleriit.ee
User-Agent: Mozilla Thunderbird 0.8 (X11/20040923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Question: advancements in proven concepts
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi and HNY!

I have one question about the "existence of collected ideas".
It is obvious that by using only proven concepts and standards have led 
the Linux on the top of the world. But it is hard to believe that you 
guys are absolutely agree with every agreement or standard ever created.
Is there a place for linux kernel community where ideas about the needed 
advancements in those proven concepts can be presented to the world in 
nice, structured and easily readable way? Or is this the professional 
property of the kernel programmer to not ask a question about the 
"healtiness" of some POSIX thing or not to give a hint for better 
hardware implementation? Well, this last question is a little nagging.


For example I found this message yesterday:

Re: ptrace single-stepping change breaks Wine
From: Linus Torvalds
Date: Sat Jan 01 2005 - 17:15:54 EST

...

<snip>

It would have been nice if Intel had added a
"single-step" bit to %db7, and then just or'ed in the values of TF and the
new flag when deciding to single-step.

<snip>

...


Maybe this idea have been said out just for fun  (btw, I have one book 
which have similar title :) ) but why not collect such things together? 
For sure there are ideas about every tool, technology or standard which 
is used for kernel development or with which the kernel have to cope 
with. Is it possible to build up such a knowledge base or is there 
similar already?

thanks,
Indrek

