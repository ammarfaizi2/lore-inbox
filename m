Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270090AbUJHSYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270090AbUJHSYi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 14:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270076AbUJHSW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 14:22:59 -0400
Received: from main.gmane.org ([80.91.229.2]:40896 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S270077AbUJHST4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 14:19:56 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ian Pilcher <i.pilcher@comcast.net>
Subject: Re: kernel BUG at kernel/workqueue.c:104!
Date: Fri, 08 Oct 2004 13:19:52 -0500
Message-ID: <ck6lo8$lh8$1@sea.gmane.org>
References: <ck4q19$tne$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-0-215-208.client.comcast.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
In-Reply-To: <ck4q19$tne$1@sea.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Pilcher wrote:
> I hit this trying to install Fedora Core 3 test 1 or test 2.  Anyone
> who's interested can see the output at:
> 
>     https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=127862
> 
> This is obviously one for Red Hat (although they appear massively
> uninterested), but I was just wondering if anyone on this list can point
> me towards a good spot to start digging.
> 

To ask the question a different way, what can a user-level program do
that will cause queue_work (in kernel/workqueue.c) to be called?

Thanks!

-- 
========================================================================
Ian Pilcher                                        i.pilcher@comcast.net
========================================================================

