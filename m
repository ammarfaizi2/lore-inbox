Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269224AbUICDKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269224AbUICDKu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 23:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269354AbUICDIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 23:08:44 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:13256 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269187AbUICDH0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 23:07:26 -0400
Message-ID: <93e09f010409022007548ce2f2@mail.gmail.com>
Date: Fri, 3 Sep 2004 08:37:22 +0530
From: Rohit Neupane <rohitneupane@gmail.com>
Reply-To: Rohit Neupane <rohitneupane@gmail.com>
To: Dax Kelson <dax@gurulabs.com>
Subject: Re: Weird Problem with TCP
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1094168287.4025.35.camel@mentorng.gurulabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <93e09f0104090202216403c08d@mail.gmail.com> <1094168287.4025.35.camel@mentorng.gurulabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Sep 2004 17:38:07 -0600, Dax Kelson <dax@gurulabs.com> wrote:
> Can you run this command:
> 
> cat /proc/net/ip_conntrack  | wc -l
> 
> And email me the results?

I don't have the file. I don't have any rule that has "state" in it.
These are the modules under ip-tables
ip_tables              16800   7  [ipt_mark ipt_MARK iptable_mangle
ipt_limit ipt_mac ipt_LOG iptable_filter]

regards,
Rohit
> 
>
