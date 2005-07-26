Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261963AbVGZTrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbVGZTrH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 15:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261978AbVGZTrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 15:47:07 -0400
Received: from kirby.webscope.com ([204.141.84.57]:5042 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S261963AbVGZTq0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 15:46:26 -0400
Message-ID: <42E692E4.4070105@m1k.net>
Date: Tue, 26 Jul 2005 15:45:41 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Radoslaw \"AstralStorm\" Szkodzinski" <astralstorm@gorzow.mm.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: MM kernels - how to keep on the bleeding edge?
References: <20050726185834.76570153.astralstorm@gorzow.mm.pl>
In-Reply-To: <20050726185834.76570153.astralstorm@gorzow.mm.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Radoslaw AstralStorm Szkodzinski wrote:

> b) It doesn't say which -mm version are they in.
> This is a real PITA, because I have to check patch list one after one to
> apply to the newest mm.

I have filters set up so that my mailer puts all mm-commits messages 
from the mailing list into a special "mm-commits" folder.  Each time 
Andrew releases an -mm kernel, I rename my "mm-commits" folder to 
"mm-commits-%version%", such as "mm-commits-2.6.13-rc3-mm2"  (I will 
probably have to create a folder like this tomorrow, or in a few 
hours/days ;-) ... Then I create a new "mm-commits" folder to hold all 
new patches not yet in the latest -mm kernel.  As of right now, my 
current "mm-commits" mail folder has 153 patches in it, although I think 
I may have lost a patch or two...

ALSO, somebody has created a -git tree that pulls from the mm-commits 
list (i think) ... Anyway, I looked at the git tree last night and it 
seems to be delayed by a few days.  I dont have that link handy right 
now.  Does anybody else have it?

-- 
Michael Krufky


