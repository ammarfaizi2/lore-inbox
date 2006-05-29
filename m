Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbWE2A2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWE2A2k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 20:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWE2A2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 20:28:40 -0400
Received: from [203.144.27.9] ([203.144.27.9]:48133 "EHLO surfers.oz.agile.tv")
	by vger.kernel.org with ESMTP id S1751079AbWE2A2k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 20:28:40 -0400
Message-ID: <447A4034.2010802@agile.tv>
Date: Mon, 29 May 2006 10:28:36 +1000
From: Tony Griffiths <tonyg@agile.tv>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060202 Fedora/1.7.12-1.5.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: PROBLEM: /proc (procfs) task exit race condition causes a kernel
 crash
References: <44764F35.9050002@agile.tv> <m1irnq6tzq.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1irnq6tzq.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

>I have tried to reproduce this.  The circumstances weren't the most
>controlled but they did overlap with what you described and I haven't seen
>anything.
>  
>
What version of the kernel and patch-set did you test against?

Over the last month I've tried *EVERYTHING* I can lay my hands on and 
can still cause a crash VERY easily!

>So I am guessing that you are having memory corruption from some source.
>Either bad ram or a bad module.
>  
>
On my DELL 1850 dual-core dual-Xeon system I did have a flaky DIMM which 
cause a few correctable ECC errors, but that has been replaced and still 
the same.  My other test systems are (multiple) DELL 1425 dual-Xeon 
machines [2.8 or 3.0 GHz chips].
 

>I'm off on vacation for a week, so I won't be able to follow up.
>  
>
Have a good one...

>
>Eric
>  
>

