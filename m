Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266478AbUAIKOB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 05:14:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266481AbUAIKOB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 05:14:01 -0500
Received: from w100.z064003144.sjc-ca.dsl.cnc.net ([64.3.144.100]:43489 "EHLO
	adrian.mariani.ws") by vger.kernel.org with ESMTP id S266478AbUAIKN7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 05:13:59 -0500
Message-ID: <3FFE7EE6.5020001@mariani.ws>
Date: Fri, 09 Jan 2004 02:13:58 -0800
From: Gianni Mariani <gianni@mariani.ws>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Repost: Possible SMP Race - 2.4.20-8smp - RH9 ?
References: <3FFAE969.1080302@mariani.ws>
In-Reply-To: <3FFAE969.1080302@mariani.ws>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gianni Mariani wrote:

>
> I'm confident that the test code (cpulat.cpp) is fine.
>
> Seems like a nasty bug in the kernel to me.  I havn't tried 2.4.24 yet.

OK - It's probably a nasty bug in the 2.4.20 kernel since I can't 
reproduce the problem with the 2.4.24 kernel.



