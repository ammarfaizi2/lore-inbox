Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265053AbUFGUsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265053AbUFGUsg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 16:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265051AbUFGUsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 16:48:36 -0400
Received: from webmail.cs.unm.edu ([64.106.20.39]:3773 "EHLO mail.cs.unm.edu")
	by vger.kernel.org with ESMTP id S265053AbUFGUsd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 16:48:33 -0400
Message-ID: <40C4DE2A.1070008@cs.unm.edu>
Date: Mon, 07 Jun 2004 15:29:14 -0600
From: Sushant Sharma <sushant@cs.unm.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: when is alloc_skb called
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan *1BXR2h-00014r-00*855g5qWQsV6*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All

I want to know which are the evnets
that can lead to the calling of alloc_skb
function which is used to allocate sk_buff.
Arrival and departure of packet are 2 events
which I know. Are there any other events/cases
which can lead to alloc_skb(...) function call in kernel.

Thanks for help
Sushant

