Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751183AbWHPOgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbWHPOgy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 10:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWHPOgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 10:36:54 -0400
Received: from main.gmane.org ([80.91.229.2]:63714 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751183AbWHPOgy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 10:36:54 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: Linux time code
Date: Wed, 16 Aug 2006 14:36:28 +0200
Organization: Palacky University in Olomouc
Message-ID: <44E3114C.1010808@flower.upol.cz>
References: <44E32B23.16949.BBB1EC4@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 158.194.192.153
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20060607 Debian/1.7.12-1.2
X-Accept-Language: en
In-Reply-To: <44E32B23.16949.BBB1EC4@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Windl wrote:
> Hi everybody!
> 
> I've been viewing recent changes to the Linux kernel (specifically 2.6.15.1 to 
> 2.6.17.8), and I felt I'll have to say something:
> 
> First there's a new routine in kernel/time.c named "set_normalized_timespec()". 
[..something....]
> Sorry if you don't like that kind of message, but I just had to say that. It seems 
> the time subsystem is already so complex that people are just adding new code 
> instead of considering redesign or reuse of the existing code.
> 
As far as i can see here's "return -ENOPATCH;" kind of mail list.
Did you read and consider cooperation with authors of:

"We Are Not Getting Any Younger: A New Approach to  Time and Timers"
<http://www.linuxsymposium.org/2005/linuxsymposium_procv1.pdf>

"Hrtimers and Beyond: Transforming the Linux Time"
Subsystems <https://ols2006.108.redhat.com/reprints/gleixner-reprint.pdf>  ?

> Regards,
> Ulrich
> 

-- 
-o--=O`C
  #oo'L O
<___=E M

