Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbVATXYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbVATXYq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 18:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbVATXYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 18:24:46 -0500
Received: from inet-mail4.oracle.com ([148.87.2.204]:13236 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id S261267AbVATXYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 18:24:38 -0500
Message-ID: <41F03D59.3030403@oracle.com>
Date: Thu, 20 Jan 2005 15:23:05 -0800
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: karim@opersys.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] tracepipe -- event streams, debugfs, and pipe_buffers
References: <41F0344C.1030404@oracle.com> <41F03CEC.4060207@opersys.com>
In-Reply-To: <41F03CEC.4060207@opersys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim Yaghmour wrote:
> Zach Brown wrote:
> 
>>Thoughts?  I, for one, am tired of writing throw-away per-cpu tracing
>>patches ;)
> 
> Have you taken a look at relayfs and ltt?

Only briefly.  They've always seemed more involved than the sort of
thing I was after.  I'll try and sit down and investigate in more detail.
