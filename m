Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264929AbUGIKc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264929AbUGIKc2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 06:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265087AbUGIKc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 06:32:28 -0400
Received: from [217.222.53.238] ([217.222.53.238]:38405 "EHLO mail.gts.it")
	by vger.kernel.org with ESMTP id S264929AbUGIKcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 06:32:22 -0400
Message-ID: <40EE742A.50407@gts.it>
Date: Fri, 09 Jul 2004 12:32:10 +0200
From: Stefano Rivoir <s.rivoir@gts.it>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm7
References: <20040708235025.5f8436b7.akpm@osdl.org>	<40EE5418.2040000@gts.it> <20040709024112.7ef44d1d.akpm@osdl.org> <40EE732C.5020404@gts.it>
In-Reply-To: <40EE732C.5020404@gts.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefano Rivoir wrote:

> It seems that hotplug "subsystem" is having problems (I use debian/sid), 
> because it stucks during
> 
> /sbin/modprobe -s -q ehci_hcd

Ahem, but "stucks" i mean that ps reports it as "D+"

-- 
Stefano RIVOIR

