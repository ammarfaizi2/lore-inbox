Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbWELPMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWELPMO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 11:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWELPMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 11:12:14 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:57831 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S932118AbWELPMN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 11:12:13 -0400
X-AuthUser: davidel@xmailserver.org
Date: Fri, 12 May 2006 08:12:06 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@alien.or.mcafeemobile.com
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
cc: jimmy <jimmyb@huawei.com>, Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux poll() <sigh> again
In-Reply-To: <Pine.LNX.4.61.0605121050060.9212@chaos.analogic.com>
Message-ID: <Pine.LNX.4.64.0605120809490.15220@alien.or.mcafeemobile.com>
References: <6bkl7-56Y-11@gated-at.bofh.it> <4463D1E4.5070605@shaw.ca>
 <Pine.LNX.4.61.0605120745050.8670@chaos.analogic.com> <44649C85.5000704@shaw.ca>
 <44649FAB.4080806@huawei.com> <Pine.LNX.4.61.0605121050060.9212@chaos.analogic.com>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 May 2006, linux-os (Dick Johnson) wrote:

> If linux doesn't support POLLHUP, then it shouldn't be documented.
> I got the same king of crap^M^M^M^Mresponse the last time I reported
> this __very__ __obvious__ defect!  The information is available
> in the kernel. It should certainly report it, just like other
> operating systems do, including <shudder> wsock32.

Try to search the list (and the source) for POLLRDHUP ...


- Davide


