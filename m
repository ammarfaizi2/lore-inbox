Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267237AbUHOXYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267237AbUHOXYJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 19:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267243AbUHOXYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 19:24:09 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:58516 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S267237AbUHOXYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 19:24:05 -0400
Message-ID: <411FF093.5090502@comcast.net>
Date: Sun, 15 Aug 2004 16:24:03 -0700
From: John Wendel <jwendel10@comcast.net>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8.1 Mis-detect CRDW as CDROM
References: <411FD919.9030702@comcast.net> <1092603225.18415.2.camel@localhost.localdomain>
In-Reply-To: <1092603225.18415.2.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Sul, 2004-08-15 at 22:43, John Wendel wrote:
>  
>
>>K3B detects my Lite-on LTR-52327S CDRW as a CDROM when run with 2.6.8.1. 
>>Booting back into 2.6.7 corrects the problem. I've attached the (totally 
>>uninteresting parts of) dmesg.  Any clues  appreciated.
>>    
>>
>
>The kernel really has no understanding of the difference here, and
>the two dmesg files are identical so what makes you make that claim
>
>
>  
>
What claim? I'm not claiming anything, just trying to report a problem. 
I don't have the slightest idea what might be causing this problem, but 
the problem is real. I can see that the dmesg files are identical which 
is why I said they were "totally uninteresting".  Since the new kernel 
is the only variable in this situation, I thought it reasonable to 
request help from you kernel gods.  Sorry, I'll now crawl back under my 
rock.

John Wendel
